<template>
  <div
    class="w-32 flex-shrink-0 aspect-[7/8] bg-white flex flex-col items-center transition duration-300 hover:scale-110 cursor-pointer rounded-2xl"
  >
    <img :src="img" :alt="name" class="w-full h-full object-cover rounded-2xl" />

    <div class="w-full h-auto text-black p-2 rounded-b-2xl text-center">
      <p class="text-sm font-bold">{{ name }}</p>
      <p class="text-sm ">As</p>
    </div>
  </div>
</template>

<script setup>
defineProps({
  img: String,
  name: String,
});
</script>
