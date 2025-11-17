<template>
  <div class="p-8 ">
    <h1 class="font-bold text-2xl">POPULAR MOVIES</h1>
    <div class="gap-4 p-6 flex overflow-x-auto custom-scrollbar">
      <img src="/img/image.png" alt="" class="h-80 mb-4 cursor-pointer hover:opacity-75 hover:scale-110 duration-150" />
      <img src="/img/image.png" alt="" class="h-80 mb-4 cursor-pointer hover:opacity-75 hover:scale-110 duration-150" />
      <img src="/img/image.png" alt="" class="h-80 mb-4 cursor-pointer hover:opacity-75 hover:scale-110 duration-150" />
      <img src="/img/image.png" alt="" class="h-80 mb-4 cursor-pointer hover:opacity-75 hover:scale-110 duration-150" />
      <img src="/img/image.png" alt="" class="h-80 mb-4 cursor-pointer hover:opacity-75 hover:scale-110 duration-150" />
      <img src="/img/image.png" alt="" class="h-80 mb-4 cursor-pointer hover:opacity-75 hover:scale-110 duration-150" />
      <img src="/img/image.png" alt="" class="h-80 mb-4 cursor-pointer hover:opacity-75 hover:scale-110 duration-150" />
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style>
.custom-scrollbar::-webkit-scrollbar {
  height: 8px;              /* ความสูง scrollbar */
}

.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;      /* สี track (bg-gray-200) */
}

.custom-scrollbar::-webkit-scrollbar-thumb {
  background-color: #505050; /* สี thumb (bg-gray-400) */
  border-radius: 8px;
}

.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #818181; /* สี hover */
}
</style>
