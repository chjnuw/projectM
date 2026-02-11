import { defineEventHandler, getCookie } from "h3";
import { db } from "~/server/db";

export default defineEventHandler(async (event) => {
  const userId = getCookie(event, "user_id");
  if (!userId) return [];

  const [rows]: any = await db.query(
    `
  SELECT t.id, t.name, ut.created_at
  FROM user_tags ut
  JOIN tag t ON t.id = ut.tag_id
  WHERE ut.user_id = ?
  ORDER BY ut.created_at ASC, ut.id ASC
  `,
    [userId],
  );

  return rows;
});
