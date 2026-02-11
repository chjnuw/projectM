import { getCookie } from "h3";
import { db } from "~/server/db";

export default defineEventHandler(async (event) => {
  const userId = getCookie(event, "user_id");

  if (!userId) {
    return null; // ❗ อย่า throw 401 สำหรับ navbar
  }

  const [rows]: any = await db.query(
    `
    SELECT id, username, image, gender
    FROM user
    WHERE id = ?
    `,
    [userId]
  );

  return rows?.[0] || null;
});