<template>
  <div class="w-full grid grid-cols-[auto_1fr_auto] items-center gap-3">
    <!-- Left -->
    <button
      class="w-10 h-10 rounded-md bg-slate-700 hover:bg-slate-600 text-white flex items-center justify-center transition disabled:opacity-30"
      @click="scrollLeft"
      :disabled="!canScrollLeft"
    >
      <FontAwesomeIcon icon="fa-solid fa-arrow-left" />
    </button>

    <!-- Scroll Area -->
    <div
      ref="scrollEl"
      class="flex gap-3 overflow-x-auto overflow-y-hidden scroll-smooth custom-scrollbar"
      @scroll="checkScroll"
    >
      <slot />
    </div>

    <!-- Right -->
    <button
      class="w-10 h-10 rounded-md bg-slate-700 hover:bg-slate-600 text-white flex items-center justify-center transition disabled:opacity-30"
      @click="scrollRight"
      :disabled="!canScrollRight"
    >
      <FontAwesomeIcon icon="fa-solid fa-arrow-right" />
    </button>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from "vue";

const scrollEl = ref<HTMLElement | null>(null);

const canScrollLeft = ref(false);
const canScrollRight = ref(true);

const SCROLL_AMOUNT = 800;

const scrollLeft = () => {
  scrollEl.value?.scrollBy({
    left: -SCROLL_AMOUNT,
    behavior: "smooth",
  });
};

const scrollRight = () => {
  scrollEl.value?.scrollBy({
    left: SCROLL_AMOUNT,
    behavior: "smooth",
  });
};

const checkScroll = () => {
  if (!scrollEl.value) return;

  const { scrollLeft, scrollWidth, clientWidth } = scrollEl.value;

  canScrollLeft.value = scrollLeft > 0;
  canScrollRight.value = scrollLeft + clientWidth < scrollWidth - 5;
};

onMounted(() => {
  if (!scrollEl.value) return;

  const observer = new ResizeObserver(() => {
    checkScroll();
  });

  observer.observe(scrollEl.value);

  nextTick(() => checkScroll());
});

const scrollToStart = () => {
  scrollEl.value?.scrollTo({
    left: 0,
    behavior: "smooth",
  });
};

defineExpose({ scrollToStart });
</script>
