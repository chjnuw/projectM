<template>
  <transition name="fade" duration="500">
    <div
      v-if="true"
      class="fixed inset-0 flex items-center justify-center z-50 border-2 border-white min-h-screen "
    >
      <div
        class="bg-black rounded-lg w-[60%] h-[85%] mt-20 overflow-y-auto items-center justify-center grid grid-cols-4 border"
      >
        <div
          class="cols-span-1 flex-1 bg-[#000000] p-4 text-white flex flex-col items-center justify-center border"
        >
          <img
            src="/img/luca.png"
            alt="posterLuca"
            class="rounded-xl w-[180px] h-[291px] object-cover border-2"
          />
          <h1 class="mt-5 w-[100px] flex items-center justify-center">
            Luca (2021)
          </h1>
          <img src="/img/review.png" alt="" class="mt-3" />
          <h2 class="mt-6">Director</h2>
          <img
            src="/img/directorex..png"
            alt=""
            class="w-[130px] h-[130px] mt-3"
          />
          <h2 class="mt-3">Enrico Casarosa</h2>
          <button
            class="w-[100px] h-[35px] bg-[#90CB38] flex items-center justify-center gap-2 rounded-sm px-2 mt-3 mb-2 cursor-pointer hover:bg-[#ffffff]/65"
          >
            <img src="/img/iconPlay.png" alt="" class="w-[15px] h-5" />
            <span class="text-white">PLAY</span>
          </button>
        </div>

        <div
          class="w-full h-60 bg-[#0B0A0A] text-white cols-span-3  items-start"
        >
          <div class="relative bg-[#0B0A0A] bg-cover border">
            <img
              src="/img/image.png"
              alt=""
              class="w-full h-full object-cover"
            />

            <font-awesome-icon
              icon="fa-solid fa-play"
              class="w-10 h-[50px] absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 z-10"
            />
          </div>
          <div class="w-full h-auto p-5">
            <p class="">
              Luca’s summer adventure follows a young sea monster who disguises
              himself as a human. He forms a strong friendship with Alberto, and
              together they try to keep their true identities a secret while
              living like human boys in a seaside village in Italy. Their goal
              is to win a prize to buy a Vespa scooter.
              <span
                class="ml-3 underline underline-offset-4 decoration-[#90CB38] text-[#90CB38] cursor-pointer hover:text-[#e2f6c3] hover:decoration-[#e2f6c3]"
              >
                see more</span
              >
            </p>
            <h2 class="mt-4">Actor :</h2>
            <div class="flex mt-3 gap-3.5">
              <imgNameAct
                v-for="(actor, index) in actors"
                :key="index"
                :img="actor.profile"
                :name="actor.name"
              />
            </div>
            <div class="flex justify-center">
              <button
                class="w-[115px] h-[35px] bg-[#ffffff]/65 flex items-center justify-center gap-2 rounded-sm px-2 mt-3 mb- cursor-pointer hover:bg-[#90CB38]"
              >
                <font-awesome-icon
                  icon="fa-solid fa-heart"
                  class="w-[22px] h-[22px] inline-block mt-1.5"
                />
                <span class="text-white">Favorite</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>
<script setup>
import imgNameAct from "./imgNameAct.vue";

const actors = [
  { name: "Jacob Tremblay", profile: "/img/luca.png" },
  { name: "Jacob Tremblay", profile: "/img/luca.png" },
  { name: "Jacob Tremblay", profile: "/img/luca.png" },
  { name: "Jacob Tremblay", profile: "/img/luca.png" },
  { name: "Jacob Tremblay", profile: "/img/luca.png" },
];
</script>
