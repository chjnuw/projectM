import { $fetch } from "ofetch";
import { defineEventHandler, getCookie } from "h3";
import { db } from "~/server/db";

type TagWeight = {
  genreId: number;
  weight: number;
};

type Movie = {
  id: number;
  popularity: number;
  vote_average: number;
  vote_count: number;
  genre_ids: number[];
};

type ScoredMovie = Movie & {
  _score: number;
  _matchedTags: number;
};

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig();
  const userId = getCookie(event, "user_id");
  if (!userId) return [];

  // 🔹 tag เก่า → ใหม่
  const [rows]: any = await db.query(
    `
    SELECT t.tmdb_genre_id, ut.created_at
    FROM user_tags ut
    JOIN tag t ON t.id = ut.tag_id
    WHERE ut.user_id = ?
    ORDER BY ut.created_at ASC
    `,
    [userId],
  );

  if (!rows.length) return [];

  const tagWeights: TagWeight[] = rows
    .map((row: any, index: number) => ({
      genreId: row.tmdb_genre_id,
      weight: index === 0 ? 3 : index === 1 ? 2 : 1,
    }))
    .filter((t: TagWeight) => !!t.genreId);

  const genreIds = tagWeights.map((t) => t.genreId);

  // 🔹 ดึงหลาย page
  const movies: Movie[] = [];
  for (const page of [1, 2, 3, 4, 5]) {
    const res: any = await $fetch(
      "https://api.themoviedb.org/3/discover/movie",
      {
        headers: {
          Authorization: `Bearer ${config.TMDB_READ_TOKEN}`,
        },
        query: {
          with_genres: genreIds.join(","),
          sort_by: "popularity.desc",
          vote_count_gte: 50,
          language: "th-TH",
          page,
        },
      },
    );

    if (res?.results) movies.push(...res.results);
  }

  // 🔥 แยกเป็น 3 tier
  const tier3: ScoredMovie[] = [];
  const tier2: ScoredMovie[] = [];
  const tier1: ScoredMovie[] = [];

  for (const movie of movies) {
    const genres = movie.genre_ids || [];

    const old = tagWeights[0]?.genreId;
    const mid = tagWeights[1]?.genreId;
    const newest = tagWeights[2]?.genreId;

    const hasOld = !!old && genres.includes(old);
    const hasMid = !!mid && genres.includes(mid);
    const hasNew = !!newest && genres.includes(newest);

    let tier = 0;

    // 🏆 Tier 3: ครบทุกแท็กจริง ๆ เท่านั้น
    if (hasOld && hasMid && hasNew) {
      tier = 3;
    }

    // 🥈 Tier 2: ต้องมี mid + (old หรือ new)
    // ❌ แต่ห้ามครบทุกแท็ก
    else if (hasMid && hasNew && !hasOld) {
      tier = 2;
    }

    // 🥉 Tier 1: มี newest อย่างเดียวจริง ๆ
    else if (hasNew && !hasOld && !hasMid) {
      tier = 1;
    } else {
      continue;
    }

    const score =
      (movie.vote_average || 0) / Math.log((movie.vote_count || 1) + 10);

    const scored: ScoredMovie = {
      ...movie,
      _matchedTags: [hasOld, hasMid, hasNew].filter(Boolean).length,
      _score: score,
    };

    if (tier === 3) tier3.push(scored);
    else if (tier === 2) tier2.push(scored);
    else tier1.push(scored);
  }

  function shuffleArray<T>(array: T[]): T[] {
    return [...array].sort(() => Math.random() - 0.5);
  }

  // 🔹 sort ภายใน tier
  tier3.sort((a, b) => b._score - a._score);
  tier2.sort((a, b) => b._score - a._score);
  tier1.sort((a, b) => b._score - a._score);

  // ⭐ randomize เล็กน้อยใน tier
const randomizedTier3 = shuffleArray(tier3.slice(0, 15));
const randomizedTier2 = shuffleArray(tier2.slice(0, 15));
const randomizedTier1 = shuffleArray(tier1.slice(0, 15));

  // 🔹 quota 3 : 2 : 1 จาก 20 เรื่อง
  const TOTAL = 20;
  const q3 = 10;
  const q2 = 7;
  const q1 = 3;

  let result: ScoredMovie[] = [];
  result.push(...randomizedTier3.slice(0, q3));
  result.push(...randomizedTier2.slice(0, q2));
  result.push(...randomizedTier1.slice(0, q1));

  // 🔹 ถ้าไม่ครบ เติมจาก tier บนลงล่าง
  if (result.length < TOTAL) {
    const rest = [...tier3.slice(q3), ...tier2.slice(q2), ...tier1.slice(q1)];
    result.push(...rest.slice(0, TOTAL - result.length));
  }

  // 🔹 กันซ้ำ
  const finalFeed = Array.from(new Map(result.map((m) => [m.id, m])).values());

  return finalFeed;
});
