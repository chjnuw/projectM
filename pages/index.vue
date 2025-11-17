<template>
  <div class="overflow-auto bg-black text-white min-h-screen">
    <div>
      <img src="/img/bg.png" class="w-full h-full " />
      <div class="absolute inset-0 bg-gradient-to-r from-transparent via-black/20 to-black/100 overflow-hidden h-[80%]"></div>
      <span class="absolute right-[5%] top-[15%] text-white p-4 w-1/3 ">
        <p class="text-6xl font-bold text-shadow-black">
          300: RISE OF AN EMPIRE
        </p>
        <p class="mt-4 text-shadow-black text-2xl ">
               the Greek general Themistocles uniting the city-states to lead the
          naval charge against the invading Persian forces, commanded by the
          vengeful Artemisia under the god-king Xerxes.
        </p>
        <div class="justify-self-center space-x-14 mt-20">
          <button class="bg-green-500 w-40 h-13 rounded-xl text-shadow-md drop-shadow-xl/50 cursor-pointer ">
           <span class="pr-1"><font-awesome-icon icon="fa-solid fa-play" /></span>Trailer
          </button>
          <button class="bg-gray-500 w-40 h-13 rounded-xl text-shadow-md drop-shadow-xl/50 cursor-pointer">
            <span class="pr-1"><font-awesome-icon icon="fa-regular fa-heart" /></span>Favorite
          </button>
        </div>
      </span>
    </div>
    <PopularM />
    <PopularM />
  </div>
</template>
<script></script>

<style></style>
