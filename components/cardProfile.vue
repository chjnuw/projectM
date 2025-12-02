<template>
    <div class="w-[1100px] h-[600px] bg-[#D9D9D9]/10 rounded-4xl flex flex-col mt-35 gap-5 justify-center items-center">

        <div class="relative">

            <!-- รูปโปรไฟล์ -->
            <img 
                :src="userData.image" 
                class="w-[150px] h-[150px] rounded-full object-cover border-2 border-white" 
            />

            <!-- ไอคอนอัปโหลดรูป (แสดงเฉพาะตอน Edit) -->
            <label 
                v-if="isEditing"
                for="fileInput"
                class="w-8 h-8 bg-[#00000080] backdrop-blur-sm rounded-full absolute bottom-2 right-2 
                       flex justify-center items-center cursor-pointer hover:bg-[#00000099]"
            >
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 28 28" class="text-white">
                    <path fill="currentColor"
                        d="M19.289 3.15a3.932 3.932 0 1 1 5.56 5.56l-1.54 1.54l-5.56-5.56zm-2.6 2.6L4.502 17.937c-.44.44-.76.986-.928 1.586l-1.547 5.525a.75.75 0 0 0 .924.924l5.524-1.547a3.6 3.6 0 0 0 1.587-.928L22.25 11.311z" />
                </svg>
            </label>

            <!-- input file (ซ่อน) -->
            <input 
                id="fileInput" 
                type="file" 
                accept="image/*" 
                class="hidden" 
                @change="onImageChange"
            />
        </div>

        <!-- Name -->
        <div class="flex flex-col w-[363px] gap-1">
            <label class="text-white text-sm font-bold">Name</label>
            <input 
                type="text" 
                v-model="userData.name"
                :disabled="!isEditing"
                class="w-full h-12 bg-[#FFFFFF]/40 rounded-2xl px-4 text-white disabled:cursor-not-allowed" 
            />
        </div>

        <!-- Email -->
        <div class="flex flex-col w-[363px] gap-1">
            <label class="text-white text-sm font-bold">Email</label>
            <input 
                type="text" 
                v-model="userData.email"
                :disabled="!isEditing"
                class="w-full h-12 bg-[#FFFFFF]/40 rounded-2xl px-4 text-white disabled:cursor-not-allowed" 
            />
        </div>

        <!-- ปุ่ม -->
        <button
            class="w-[180px] h-[45px] bg-[#90CB38] rounded-2xl text-white font-medium text-lg hover:bg-[#7fbb32] cursor-pointer"
            @click="toggleEdit"
        >
            {{ isEditing ? 'Confirm' : 'Edit' }}
        </button>

        <button @click="showDelete = true" class="text-white/80 underline hover:text-white text-sm cursor-pointer">
            Delete Account
        </button>

        <DeletePopup v-if="showDelete" @close="showDelete = false" />

    </div>
</template>

<script setup>
import { ref } from 'vue';
import DeletePopup from './deletePopup.vue';

const showDelete = ref(false);


const userData = ref({
    name: "Chisanupong",
    email: "Chisanupong0132@gmail.com",
    image: "/img/directorex..png"  // รูปเริ่มต้น
});

const isEditing = ref(false);


const onImageChange = (e) => {
    const file = e.target.files[0];
    if (!file) return;

    // แสดงรูป preview ทันที
    userData.value.image = URL.createObjectURL(file);
};

// ปุ่ม Edit / Confirm
const toggleEdit = () => {
    if (isEditing.value) {
        console.log("Saved Data:", userData.value);
        isEditing.value = false;
    } else {
        isEditing.value = true;
    }
};
</script>
