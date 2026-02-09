<template>
  <div
    class="fixed inset-0 z-50 bg-black/80 flex items-center justify-center px-4"
  >
    <!-- กล่องหลัก -->
    <div class="relative w-full max-w-[380px] text-white">
      <div class="relative">
        <button
          class="fixed top-4 right-6 bg-black/50 text-white px-3 py-1 rounded-full cursor-pointer text-white/70 hover:text-white transition duration-200"
          @click="$emit('close')"
        >
          <FontAwesomeIcon icon="fa-solid fa-xmark" />
        </button>
      </div>
      <!-- Poster -->
      <div class="flex justify-center">
        <img
          :src="posterSrc"
          class="aspect-[2/3] object-cover rounded-3xl shadow-xl w-[240px] sm:w-[260px] md:w-[300px]"
        />
      </div>

      <!-- Info -->
      <div class="text-center mt-4 px-2">
        <h2 class="text-base sm:text-lg font-bold leading-snug line-clamp-2">
          {{ movie.title }}
        </h2>

        <p class="text-xs sm:text-sm text-gray-400 mt-1">
          {{ releaseYear }} &nbsp; | &nbsp; ⭐
          {{ movie.vote_average?.toFixed(1)
          }}<span class="text-[10px] sm:text-xs text-gray-400 ml-2">
            ({{ movie.vote_count ?? 0 }})
          </span>
        </p>

        <!-- Genres -->
        <div
          class="flex justify-center gap-2 mt-2 text-[10px] sm:text-xs text-gray-300 flex-wrap"
        >
          <span
            v-for="gid in movie.genre_ids || []"
            :key="gid"
            class="opacity-80 p-2 bg-gray-700 rounded-md hover:bg-gray-800 transition text-xs"
          >
            #{{ genreMap[gid] }}
          </span>
        </div>
      </div>

      <!-- Buttons -->
      <div class="flex gap-3 mt-6 px-2">
        <!-- RANDOM AGAIN -->
        <button
          @click="onRetry"
          class="flex-1 py-2.5 sm:py-3 rounded-full bg-white text-red-600 font-bold hover:bg-[#c9c9c9] cursor-pointer text-sm sm:text-base"
        >
          สุ่มใหม่
        </button>

        <!-- VIEW DETAIL -->
        <button
          @click="onView"
          class="flex-1 py-2.5 sm:py-3 rounded-full bg-[#90CB38] hover:bg-[#72a02c] text-white font-bold cursor-pointer text-sm sm:text-base"
        >
          ดูรายละเอียด
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, watch, onMounted, onUnmounted, ref } from "vue";
import type { Movie } from "@/Type/tmdb";
import { genreMap } from "../composables/genreMap";

const emit = defineEmits<{
  (e: "retry"): void;
  (e: "view", id: number): void;
  (e: "close"): void;
}>();

const props = defineProps<{
  movie: Movie;
}>();

const posterSrc = computed(() =>
  props.movie.poster_path
    ? "https://image.tmdb.org/t/p/w500" + props.movie.poster_path
    : "/img/no-poster.png",
);

const releaseYear = computed(() =>
  props.movie.release_date ? props.movie.release_date.slice(0, 4) : "N/A",
);

const starCount = computed(() =>
  Math.round((props.movie.vote_average || 0) / 2),
);

const onRetry = () => {
  emit("retry");
};

const onView = () => {
  emit("view", props.movie.id);
};

import {
  lockBodyScroll,
  unlockBodyScroll,
} from "../composables/useBodyScrollLock";

onMounted(() => {
  lockBodyScroll();
});

onUnmounted(() => {
  unlockBodyScroll();
});

const handleEsc = (e: KeyboardEvent) => {
  if (e.key === "Escape") {
    emit("close");
  }
};

onMounted(() => {
  lockBodyScroll();
  window.addEventListener("keydown", handleEsc);
});

onUnmounted(() => {
  unlockBodyScroll();
  window.removeEventListener("keydown", handleEsc);
});
</script>
