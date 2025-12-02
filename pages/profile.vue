<template>
    <div  class="w-full h-[1000px] flex bg-[#0B0A0A]  gap-20 ">
        <!-- กล่องซ้าย -->
        <div class="w-[350px] h-[450px] bg-[#0B0A0A] mt-35 rounded-4xl flex flex-col  shadow-2xl z-1">
            <div
                @click="activeTab = 'profile'"
                class="absolute z-10 w-[350px] h-[60px] bg-[#0B0A0A] rounded-tr-4xl  hover:bg-[#90CB38] cursor-pointer flex items-center justify-center">
                <h1 class="font-medium text-white text-[20px]">Profile</h1>
            </div>
            <div
            @click="activeTab = 'password'"
                class="mt-14.5 z-10 w-[350px] h-[60px] bg-[#0B0A0A]  hover:bg-[#90CB38] cursor-pointer flex items-center justify-center">
                <h1 class="font-medium text-white text-[20px]">Password</h1>
            </div>

            <div
            @click="showLogout = true"
                class="mt-68 z-10 w-[350px] h-[60px] bg-[#151414]  hover:bg-[#90CB38] rounded-br-4xl  cursor-pointer flex items-center justify-center">
                <h1 class="font-medium text-[#eb1313] text-[20px]">Log out</h1>
            </div>


        </div>

        <!-- กล่องขวา -->
    <CardProfile v-if="activeTab === 'profile'" />
    <CardProfilepassword v-if="activeTab === 'password'"/>
    <logout v-if="showLogout" @close="showLogout =false"/>


    </div>
</template>

<script setup>
import CardProfile from '~/components/cardProfile.vue';
import CardProfilepassword from '~/components/cardProfilepassword.vue';
import { ref } from 'vue';
import logout from '~/components/logout.vue';

const activeTab = ref("profile")
const showLogout =ref(false)



// definePageMeta({ layout: "Profile" });


</script>