<template>
  <footer
    class="relative bg-black text-white flex items-center justify-center h-50 border-t-2 border-gray-700"
  >
    <button
      class="fixed top-[85vh] translate-y-[-50%] bg-gray-800 hover:bg-gray-700 text-white font-bold p-4 rounded-full duration-300 cursor-pointer text-2xl"
      :class="[
        buttonOnTop === 'show'
          ? 'opacity-100 translate-y-0 transition-all duration-500 '
          : 'opacity-0 translate-y-10 pointer-events-none ',
      ]"
      @click="OnTop"
    >
      <font-awesome-icon
        icon="fa-solid fa-arrow-up"
        class="transition-transform duration-500"
        :class="buttonOnTop === 'show' ? 'rotate-0' : 'rotate-180'"
      />
    </button>
    <div class="p-4 text-center flex items-center justify-center">
      Footer Component
    </div>
  </footer>
</template>
<script setup>
import { ref, onMounted, onUnmounted } from "vue";
let lastScroll = 0;
const buttonOnTop = ref("hidden");

const handleScroll = () => {
  const currentScroll = window.scrollY ;

  if (currentScroll <= 50) {
    buttonOnTop.value = "hidden";
    lastScroll = currentScroll;
    return;
  }

  if (currentScroll < lastScroll) {
    // กำลังเลื่อนขึ้น
    buttonOnTop.value = "show";
  } else {
    // กำลังเลื่อนลง
    buttonOnTop.value = "hidden";
  }

  lastScroll = currentScroll;
};
onMounted(() => {
  window.addEventListener("scroll", handleScroll);
});

onUnmounted(() => {
  window.removeEventListener("scroll", handleScroll);
});

const OnTop = () => {
  window.scrollTo({ top: 0, behavior: "smooth" });
};
</script>
