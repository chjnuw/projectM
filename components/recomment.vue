<template>
  <div class="px-2 sm:px-4 mx-auto">
    <div
      class="gap-2 py-4 px-2 flex overflow-x-auto overflow-y-hidden custom-scrollbar"
    >
      <div
        v-for="(movie, index) in movies"
        :key="movie.id"
        class="relative group cursor-pointer transition-transform duration-300 "
        @click="$emit('open', movie.id)"
      >
        <!-- Ribbon -->
        <div
          class="absolute left-0 top-3 z-30 px-3 py-1 text-xs font-bold text-white rounded-r-lg shadow-md transition-all duration-300 group-hover:brightness-110"
          :class="{
            'bg-gradient-to-r from-yellow-400 to-orange-500': index === 0,
            'bg-gradient-to-r from-gray-300 to-gray-500': index === 1,
            'bg-gradient-to-r from-amber-500 to-orange-700': index === 2,
            'bg-black/70': index > 2,
          }"
        >
          TOP {{ index + 1 }}
        </div>

        <CardM
          :movie="movie"
          :class="[
            'relative z-20 aspect-[2/3] rounded-xl overflow-hidden flex-shrink-0',
            'transition-all duration-300',
            'shadow-md hover:shadow-2xl ',
            index < 3 && 'ring-2 ring-yellow-400/50',
            cardClass,
          ]"
        />
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import { $fetch } from "ofetch";

const props = withDefaults(
  defineProps<{
    size?: "xs" | "sm" | "md" | "lg";
  }>(),
  {
    size: "md",
  },
);

const movies = ref<any[]>([]);
const isLoadingDetail = ref(false);

console.log("recommend called");

const recommend = async () => {
  isLoadingDetail.value = true;
  try {
    const res = await $fetch<any>("/api/recommend/movies", {
      method: "POST",
      credentials: "include",
    });

    console.log("recommend res:", res);

    movies.value = Array.isArray(res) ? res : (res.movies ?? res.results ?? []);
  } catch (err) {
    console.error("Failed to load recommendations", err);
    movies.value = [];
  } finally {
    isLoadingDetail.value = false;
  }
};

defineEmits<{
  (e: "open", id: number): void;
}>();

const cardClass = computed(() => {
  switch (props.size) {
    case "xs":
      return "w-24 sm:w-28";
    case "sm":
      return "w-28 sm:w-32";
    case "lg":
      return "w-44 sm:w-52";
    default: // md
      return "w-34 sm:w-40";
  }
});

onMounted(() => {
  recommend();
});
</script>
