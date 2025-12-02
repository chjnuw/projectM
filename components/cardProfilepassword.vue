<template>
      <div class="w-[1100px] h-[600px] bg-[#D9D9D9]/10 rounded-4xl flex flex-col mt-35 gap-5 justify-center items-center">

    <!-- รูปโปรไฟล์ -->
    <div class="relative">
        <img 
            src="/img/directorex..png" 
            class="w-[150px] h-[150px] rounded-full object-cover"
        />
    </div>

    <!-- Name -->
    <div class="flex flex-col w-[363px] gap-1">
            <label class="text-white text-sm font-bold">Password</label>
            <input 
                type="text" 
                v-model="userData.email"
                :disabled="!isEditing"
                class="w-full h-12 bg-[#FFFFFF]/40 rounded-2xl px-4 text-white disabled:cursor-not-allowed" 
            />
        </div>


    <!-- ปุ่ม Edit -->
    <button
            class="w-[180px] h-[45px] bg-[#90CB38] rounded-2xl text-white font-medium text-lg hover:bg-[#7fbb32] cursor-pointer"
            @click="toggleEdit"
        >
            {{ isEditing ? 'Confirm' : 'Edit' }}
        </button>
</div>
</template>
<script setup>


const isEditing = ref(false);


const toggleEdit = () => {
    if (isEditing.value) {
        console.log("Saved Data:", userData.value);
        isEditing.value = false;
    } else {
        isEditing.value = true;
    }
};
const userData = ref({
    email: "123456789",
});
</script>