type TasteScore = {
  genre_id: number
  score: number
}

type TasteCompare = {
  genre_id: number
  current: number
  previous: number
  diff: number
}

export const compareTaste = (
  current: TasteScore[] = [],
  previous: TasteScore[] = []
): TasteCompare[] => {
  const map = new Map<number, { current: number; previous: number }>()

  current.forEach(g => {
    map.set(g.genre_id, { current: g.score, previous: 0 })
  })

  previous.forEach(g => {
    if (map.has(g.genre_id)) {
      map.get(g.genre_id)!.previous = g.score
    } else {
      map.set(g.genre_id, { current: 0, previous: g.score })
    }
  })

  return Array.from(map.entries()).map(([genre_id, v]) => ({
    genre_id,
    current: v.current,
    previous: v.previous,
    diff: v.current - v.previous
  }))
}
