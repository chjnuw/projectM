<template>
  <div class="fixed inset-0 z-50 bg-black/70 flex items-center justify-center">
    <div class="relative w-[520px] bg-[#0f0f0f] rounded-3xl p-6 text-white">

      <!-- close -->
      <button
        @click="$emit('close')"
        class="absolute top-4 right-4 text-xl hover:text-red-400 cursor-pointer"
      >
        ✕
      </button>

      <!-- title -->
      <h2 class="text-2xl font-bold text-center mb-6">
        🎰 สุ่มหนังจากรายการโปรด
      </h2>

      <!-- SLOT WINDOW -->
      <div
        class="relative overflow-hidden h-[180px] border-4 rounded-2xl transition-all duration-300"
        :class="{
          'border-[#90CB38] shadow-[0_0_25px_#9AFF00]': isWin,
          'border-[#444]': !isWin
        }"
      >
        <!-- overlay -->
        <div class="absolute top-0 left-0 right-0 h-8 bg-gradient-to-b from-black z-10"></div>
        <div class="absolute bottom-0 left-0 right-0 h-8 bg-gradient-to-t from-black z-10"></div>
        <!-- <div class="absolute top-1/2 left-0 right-0 h-[2px] bg-[#9AFF00]/80 z-20"></div> -->

        <!-- SLOT LIST -->
        <div
          class="transition-transform duration-[2000ms] ease-out"
          :style="{ transform: `translateY(-${translateY}px)` }"
        >
          <div
            v-for="(movie, index) in slotMovies"
            :key="index"
            class="h-[180px] flex items-center gap-4 px-4"
          >
            <img
              :src="movie.poster_path
                ? 'https://image.tmdb.org/t/p/w500' + movie.poster_path
                : '/img/no-poster.png'"
              class="w-[100px] h-[150px] object-cover rounded-xl"
            />
            <div>
              <h3 class="text-2xl font-medium line-clamp-2 ">
                {{ movie.title }}
              </h3>
            </div>
          </div>
        </div>
      </div>

      <!-- SPIN BUTTON -->
      <div class="flex justify-center mt-8">
        <button
          @click="spin"
          :disabled="isSpinning || movies.length === 0"
          class="px-12 py-3 rounded-full font-bold text-black
                 bg-gradient-to-r from-[#9AFF00] to-[#4CAF50]
                 hover:scale-105 transition disabled:opacity-50 cursor-pointer"
        >
          {{ isSpinning ? 'SPINNING...' : 'SPIN 🎲' }}
        </button>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch } from "vue"
import { useFavorite } from "../composables/useFavorites"
const emit = defineEmits<{
  (e: "close"): void
  (e: "result", movie: any): void
}>()

/* ---------- FAVORITES ---------- */
const { favorites, loadFavorites } = useFavorite()

onMounted(loadFavorites)

const movies = computed(() => favorites.value)

/* ---------- SLOT STATE ---------- */
const slotMovies = ref<any[]>([])
const translateY = ref(0)
const isSpinning = ref(false)
const isWin = ref(false)

/* ---------- AUDIO ---------- */
const spinSound = new Audio("/sounds/spin_soft.wav")
const winSound = new Audio("/sounds/win_soft.wav")

/* clone favorites ให้ยาว */
watch(movies, (val) => {
  if (val.length) {
    slotMovies.value = [...val, ...val, ...val]
  }
})

/* ---------- SPIN ---------- */
const spin = () => {
  if (isSpinning.value || movies.value.length === 0) return

  isSpinning.value = true
  isWin.value = false

  spinSound.loop = true
  spinSound.currentTime = 0
  spinSound.play()

  const itemHeight = 180
  const resultIndex = Math.floor(Math.random() * movies.value.length)
  const stopIndex = movies.value.length * 2 + resultIndex

  translateY.value = stopIndex * itemHeight

  const selectedMovie = movies.value[resultIndex]

  setTimeout(() => {
    spinSound.pause()
    winSound.currentTime = 0
    winSound.play()

    isSpinning.value = false
    isWin.value = true

    emit("result", selectedMovie)
  }, 2000)
}
</script>
