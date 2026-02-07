import { db } from '~/server/db'

export default defineEventHandler(async () => {
  const [rows] = await db.query('SELECT NOW() as now')
  return rows
})