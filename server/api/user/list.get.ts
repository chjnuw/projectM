import { db } from '~/server/db'

export default defineEventHandler(async () => {
  const [rows] = await db.query(
    'SELECT id, username, email, role FROM user'
  )
  return rows
})
