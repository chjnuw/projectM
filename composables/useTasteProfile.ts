import dayjs from 'dayjs'

type TasteScore = {
  genre_id: number
  genre_name: string
  score: number
}

export const useTasteProfile = async () => {
  const months = [
    dayjs().format('YYYY-MM'),
    dayjs().subtract(1, 'month').format('YYYY-MM')
  ]

  const [current, previous] = await Promise.all(
    months.map(m =>
      $fetch<TasteScore[]>(`/api/user/taste/score?month=${m}`)
        .catch(() => []) // 🔥 กัน API พัง
    )
  )

  // รวมคะแนนทุกเดือน
  const tasteDNA: Record<number, number> = {}

  ;[current, previous].forEach(list => {
    if (!Array.isArray(list)) return

    list.forEach(g => {
      tasteDNA[g.genre_id] =
        (tasteDNA[g.genre_id] ?? 0) + g.score
    })
  })

  const profile = Object.entries(tasteDNA)
    .map(([genre_id, score]) => ({
      genre_id: Number(genre_id),
      score
    }))
    .sort((a, b) => b.score - a.score)

  return {
    profile,   // 👉 โปรไฟล์รสนิยมรวม (ใช้ recommend)
    current,   // 👉 เดือนปัจจุบัน
    previous   // 👉 เดือนก่อน
  }
}