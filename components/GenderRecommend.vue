<template>
  <HorizontalScroller ref="scrollerRef">
    <div class="px-2 sm:px-4 mx-auto flex gap-2 py-4">
      <div
        v-for="movie in movies"
        :key="movie.id"
        class="transition-transform duration-300 cursor-pointer"
        @click="$emit('open', movie.id)"
      >
        <CardM
          :movie="movie"
          :class="[
            'relative z-10 aspect-[2/3] rounded-xl overflow-hidden flex-shrink-0',
            'transition-all duration-300',
            'shadow-md hover:shadow-2xl hover:-translate-y-1',
            cardClass,
          ]"
        />
      </div>
    </div>
  </HorizontalScroller>
</template>

<script setup lang="ts">
import { ref, onMounted, computed, watch } from "vue";
import { $fetch } from "ofetch";

/* ---------------- props ---------------- */
const props = withDefaults(
  defineProps<{
    endpoint: string; // ⭐ API ที่จะเรียก
    size?: "xs" | "sm" | "md" | "lg";
    genderSortMode ?: "default" | "popular" | "rating";
  }>(),
  {
    size: "md",
    genderSortMode: "default"
  },
);

/* ---------------- emits ---------------- */
defineEmits<{
  (e: "open", id: number): void;
}>();

/* ---------------- state ---------------- */
const moviesRaw = ref<any[]>([]);
const loading = ref(false);


/* ---------------- style ---------------- */
const cardClass = computed(() => {
  switch (props.size) {
    case "xs":
      return "w-24 sm:w-28";
    case "sm":
      return "w-28 sm:w-32";
    case "lg":
      return "w-44 sm:w-52";
    default:
      return "w-34 sm:w-40";
  }
});

async function fetchRecommend() {
  loading.value = true;
  try {
    const res = await $fetch<any[]>(props.endpoint, {
      credentials: "include",
    });
    moviesRaw.value = res ?? [];
  } catch (e) {
    console.error("recommend error", e);
    moviesRaw.value = [];
  } finally {
    loading.value = false;
  }
}

const movies = computed(() => {
  const list = [...moviesRaw.value];

  if (props.genderSortMode === "rating") {
    return list.sort(
      (a, b) => (b.vote_average ?? 0) - (a.vote_average ?? 0)
    );
  }

  if (props.genderSortMode === "popular") {
    return list.sort(
      (a, b) => (b.popularity ?? 0) - (a.popularity ?? 0)
    );
  }

  // ✅ default → ใช้ _score (recommend score)
  return list.sort(
    (a, b) => (b._score ?? 0) - (a._score ?? 0)
  );
});

const scrollerRef = ref<any>(null);

watch(
  () => props.genderSortMode,
  () => {
    scrollerRef.value?.scrollToStart();
  }
);

onMounted(fetchRecommend);
</script>
