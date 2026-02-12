// server/utils/db.ts
import mysql from 'mysql2/promise'

if (!process.env.MYSQL_PUBLIC_URL) {
  throw new Error('❌ MYSQL_PUBLIC_URL is missing')
}

export const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  port: Number(process.env.DB_PORT),
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 5,
  ssl: {
    rejectUnauthorized: false, // สำคัญสำหรับ Aiven
  },
})