import { $fetch } from "ofetch";
import { defineEventHandler, getCookie } from "h3";
import { db } from "~/server/db";

type Movie = {
  id: number;
  popularity: number;
  vote_average: number;
  vote_count: number;
  genre_ids: number[];
};

type RankedMovie = Movie & {
  _score: number;
  _matchedWeight: number;
};

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig();
  const userId = getCookie(event, "user_id");
  if (!userId) return [];

  // 🔹 ดึง 3 tag ล่าสุด แต่เรียงเก่าสุดก่อน
  const [rows]: any = await db.query(
    `
    SELECT t.tmdb_genre_id
    FROM user_tags ut
    JOIN tag t ON t.id = ut.tag_id
    WHERE ut.user_id = ?
    ORDER BY ut.created_at DESC
    LIMIT 3
    `,
    [userId],
  );

  if (!rows.length) return [];

  // reverse เพื่อให้เก่าสุดมาก่อน
  const genreIds: number[] = rows
    .map((r: any) => r.tmdb_genre_id)
    .filter(Boolean)
    .reverse();

  // weight 3 : 2 : 1
  const weights: [number, number, number] = [3, 2, 1];

  const movies: Movie[] = [];

  for (const page of [1, 2, 3, 4, 5]) {
    const res: any = await $fetch(
      "https://api.themoviedb.org/3/discover/movie",
      {
        headers: {
          Authorization: `Bearer ${config.TMDB_READ_TOKEN}`,
        },
        query: {
          with_genres: genreIds.join("|"),
          sort_by: "popularity.desc",
          vote_count_gte: 50,
          language: "th-TH",
          page,
        },
      },
    );

    if (res?.results) movies.push(...res.results);
  }

  const ranked: RankedMovie[] = movies
    .map((movie) => {
      const genres = movie.genre_ids || [];

      let matchedWeight = 0;

      genreIds.forEach((id, index) => {
        const weight = weights[index] ?? 0;

        if (genres.includes(id)) {
          matchedWeight += weight;
        }
      });

      if (matchedWeight === 0) return null;

      // 🎯 สูตรคะแนนหลัก
      const finalScore =
        matchedWeight * 100 + // tag สำคัญสุด
        (movie.vote_average || 0) * 5 +
        Math.log((movie.vote_count || 1) + 1) * 2 +
        Math.log((movie.popularity || 1) + 1) +
        Math.random() * 2; // soft shuffle

      return {
        ...movie,
        _matchedWeight: matchedWeight,
        _score: finalScore,
      };
    })
    .filter(Boolean) as RankedMovie[];

  ranked.sort((a, b) => b._score - a._score);

  const unique = Array.from(new Map(ranked.map((m) => [m.id, m])).values());

  return unique.slice(0, 20);
});
