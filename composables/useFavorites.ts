import { ref } from "vue"
import { useTMDB } from "./useTMDB"
import type { Movie } from "~/Type/tmdb"

export function useFavorite() {
  const favorites = ref<Movie[]>([])
  const isLoading = ref(false)
  const { getMovieDetails } = useTMDB()

  const loadFavorites = async () => {
    isLoading.value = true

    try {
      // 1. ดึง movie_id จาก DB
      const favs = await $fetch<{ movie_id: number }[]>(
        "/api/favorite",
        { credentials: "include" }
      )

      // 2. ยิง TMDB ต่อ
      const results = await Promise.all(
        favs.map(f => getMovieDetails(f.movie_id))
      )

      favorites.value = results.filter(Boolean) as Movie[]
    } catch (err) {
      console.error("load favorites error", err)
      favorites.value = []
    } finally {
      isLoading.value = false
    }
  }

  return {
    favorites,
    loadFavorites,
    isLoading
  }
}
