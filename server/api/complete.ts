import { db } from "~/server/db";

export default defineEventHandler(async (event) => {
  try {
    const body = await readBody(event);
    console.log("BODY:", body);

    const userId = Number(body.userId);
    const tags = body.tags;

    const [temp]: any = await db.query(
      "SELECT * FROM user_register_temp WHERE id = ?",
      [userId],
    );

    if (!temp || temp.length === 0) {
      return {
        ok: false,
        message: "User temp not found",
      };
    }

    console.log("TEMP:", temp);

    const u = temp[0];

    console.log("DEBUG VALUES:", {
      gender: u.gender,
      birthdate: u.birthdate,
      age: u.age,
    });

    const [res]: any = await db.query(
      `INSERT INTO \`user\`
       (username, email, password, gender, birthdate, age, role, status)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        u.username,
        u.email,
        u.password,
        u.gender,
        u.birthdate,
        u.age,
        "user",
        1,
      ],
    );

    console.log("INSERT USER OK");
    console.log("INSERTING:", [
      u.username,
      u.email,
      u.password,
      Number(u.gender),
      u.birthdate,
      u.age,
      "user",
      1,
    ]);

    return { ok: true };
  } catch (error: any) {
    console.error("🔥 COMPLETE ERROR:", error);
    return {
      ok: false,
      message: error.message,
    };
  }
});
