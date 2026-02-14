import { db } from "~/server/db";
import { getCookie, readFormData, createError, defineEventHandler } from "h3";
import { v2 as cloudinary } from "cloudinary";
import type { UploadApiResponse } from "cloudinary";

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

export default defineEventHandler(async (event) => {
  try {
    const userId = getCookie(event, "user_id");
    if (!userId) {
      throw createError({
        statusCode: 401,
        statusMessage: "Not logged in",
      });
    }

    const formData = await readFormData(event);

    const username = formData.get("username");
    const image = formData.get("image");
    const tagsRaw = formData.get("tags");

    if (!username || typeof username !== "string") {
      throw createError({
        statusCode: 400,
        statusMessage: "Username is required",
      });
    }

    const tags: number[] = tagsRaw
      ? JSON.parse(tagsRaw.toString())
      : [];

    // update username
    await db.query("UPDATE user SET username = ? WHERE id = ?", [
      username,
      userId,
    ]);

    // update image
    if (image instanceof Blob) {
      const buffer = Buffer.from(await image.arrayBuffer());

      const uploadResult = await new Promise<UploadApiResponse>(
        (resolve, reject) => {
          cloudinary.uploader
            .upload_stream({ folder: "project-m/users" }, (error, result) => {
              if (error || !result) return reject(error);
              resolve(result);
            })
            .end(buffer);
        }
      );

      await db.query("UPDATE user SET image = ? WHERE id = ?", [
        uploadResult.secure_url,
        userId,
      ]);
    }

    // update tags
    await db.query("DELETE FROM user_tags WHERE user_id = ?", [userId]);

    if (tags.length > 0) {
      const values = tags.map((tagId) => [userId, tagId]);
      await db.query(
        "INSERT INTO user_tags (user_id, tag_id) VALUES ?",
        [values]
      );
    }

    // 🔥 fetch latest data
    const [rows]: any = await db.query(
      "SELECT id, username, email, image FROM user WHERE id = ? LIMIT 1",
      [userId]
    );

    const [tagsRows]: any = await db.query(
      `SELECT t.id, t.name
       FROM user_tags ut
       JOIN tag t ON ut.tag_id = t.id
       WHERE ut.user_id = ?`,
      [userId]
    );

    return {
      ...rows[0],
      tags: tagsRows,
    };

  } catch (err) {
    console.error("PROFILE PUT ERROR:", err);
    throw err;
  }
});
