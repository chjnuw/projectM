import { Client } from 'pg'

export default defineEventHandler(async () => {
  const config = useRuntimeConfig()

  const client = new Client({
    connectionString: config.databaseUrl,
    ssl: { rejectUnauthorized: false }
  })

  await client.connect()
  const res = await client.query('SELECT now()')
  await client.end()

  return {
    status: 'ok',
    time: res.rows[0].now
  }
})
