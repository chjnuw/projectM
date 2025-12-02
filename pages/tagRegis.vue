<template>
    <div class="relative w-full h-screen flex justify-center items-center">
        <div class="absolute inset-0 bg-[url('/img/bglogin2.webp')] bg-cover bg-center"></div>
        <div class="absolute inset-0 bg-black/50"></div>
        <img src="/img/logo.png" alt="" class="shadow-2xl w-[370px] h-[370px] absolute bottom-110 left-8 z-20" />
        <div class="w-[700px] h-auto bg-white/45 rounded-[70px] shadow-2xl relative z-20 p-5">
            <div class="w-full h-full flex flex-col items-center gap-4 ">
                <h1 class="text-4xl font-bold text-[#ffffff] text-shadow-2xl">Choose Your Movie Tag !</h1>
                <h2 class="text-lg text-[#ffffff]">Choose your favorite tags and let us find the perfect movies for you.
                </h2>
                <div class="grid grid-cols-3 gap-3 w-[500px]">
                    <button v-for="tag in tags" :key="tag" @click="toggleTag(tag)" :class="[
                        'w-[156px] h-[43px] rounded-[70px] font-bold shadow-2xl cursor-pointer text-[#ffffff] text-shadow-4xl transition',
                        selectedTags.includes(tag)
                            ? 'bg-[#A0E13E]'              // สีเมื่อเลือกแล้ว
                            : 'bg-white/50 hover:bg-[#A0E13E]/70'  // สีปกติ + hover
                    ]">
                        {{ tag }}
                    </button>
                </div>

                <!-- <div class="flex gap-3 w-[500px] h-auto">
                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Action</button>

                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Horror</button>


                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Sci-Fi</button>
                </div>

                <div class="flex gap-3 w-[500px] h-auto">
                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Adventure</button>

                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);">#Drama</button>


                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Crime</button>
                </div>

                <div class="flex gap-3 w-[500px] h-auto">
                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);">#Romance</button>

                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Thriller</button>


                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Comedy</button>
                </div>

                <div class="flex gap-3 w-[500px] h-auto">
                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Animation</button>

                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Fantasy</button>


                    <button
                    class="w-[156px] h-[43px] bg-[#ffffff]/50 text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer  hover:bg-[#A0E13E]/70"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" >#Documentary</button>
                </div> -->




                <button
                    class="w-[196px] h-[43px] bg-[#A0E13E] text-[#ffffff] text-shadow-4xl rounded-[70px] font-bold shadow-2xl cursor-pointer hover:bg-[#80b432]"
                    style="text-shadow: 0px 0px 8px rgba(0,0,0,0.5);" @click="gotologin">Register</button>



            </div>


        </div>
    </div>
</template>

<script setup>
definePageMeta({ layout: "login" });
import { ref } from 'vue';
const gotologin = () => {
    navigateTo('/logInscreen')
}

const selectedTags = ref([]);
const toggleTag = (tag) => {
    // ถ้าแท็กนี้ถูกเลือกอยู่ → ยกเลิก
    if (selectedTags.value.includes(tag)) {
        selectedTags.value = selectedTags.value.filter(t => t !== tag);
        return;
    }

    // ยังไม่ครบ 3 → เลือกเพิ่มได้
    if (selectedTags.value.length < 3) {
        selectedTags.value.push(tag);
    }
};

const tags = [
    "#Action", "#Horror", "#Sci-Fi",
    "#Adventure", "#Drama", "#Crime",
    "#Romance", "#Thriller", "#Comedy",
    "#Animation", "#Fantasy", "#Documentary"
];
</script>

<style></style>
