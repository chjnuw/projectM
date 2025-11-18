<template>
  <div class="flex flex-col items-center">
    <img
      :src="img"
      :alt="name"
      class="w-[120px] h-[120px] object-cover rounded-xl"
    />
    <p class="text-white text-sm mt-1.5">{{ name }}</p>
  </div>
</template>

<script setup>
defineProps({
  img: String,
  name: String
});
</script>