import { defineEventHandler, getCookie, getQuery } from "h3";
import { db } from "~/server/db";

export default defineEventHandler(async (event) => {
  const userId = getCookie(event, "user_id");
  const { month } = getQuery(event);

  if (!userId) return [];

  const targetMonth =
    typeof month === "string" && month.length === 7
      ? month
      : new Date().toISOString().slice(0, 7);

  const [rows] = await db.query(
    `
SELECT
  mg.genre_id AS genre_id,
  t.name AS genre_name,
  COUNT(*) AS score
FROM favorites f
JOIN movie_genre mg ON mg.movie_id = f.movie_id
JOIN tag t ON t.tmdb_genre_id = mg.genre_id
WHERE f.user_id = ?
  AND f.created_at IS NOT NULL
  AND DATE_FORMAT(f.created_at, '%Y-%m') = ?
GROUP BY mg.genre_id, t.name
ORDER BY score DESC
LIMIT 12
    `,
    [userId, targetMonth],
  );

  return rows;
});
