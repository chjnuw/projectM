<template>
  <div
    class="border-2 border-white/20 px-4 sm:px-6 py-5 sm:py-7 w-full max-w-[900px] min-h-[680px] bg-[#D9D9D9]/10 rounded-3xl sm:rounded-4xl flex flex-col gap-5 sm:gap-6 justify-center items-center mx-auto"
  >
    <!-- ===== VIEW MODE ===== -->
    <template v-if="!isEditing">
      <div class="flex flex-col w-full max-w-[320px] sm:max-w-[363px] gap-1">
        <label class="text-white text-sm font-bold">รหัสผ่าน</label>
        <input
          type="password"
          value="passwordhidden"
          disabled
          class="w-full h-11 sm:h-12 bg-white/20 rounded-2xl px-4 text-white cursor-not-allowed"
        />
      </div>
    </template>

    <!-- ===== EDIT MODE ===== -->
    <template v-else>
      <!-- รหัสผ่านเก่า -->
      <div class="flex flex-col w-full max-w-[320px] sm:max-w-[363px] gap-1">
        <label class="text-white text-sm font-bold">รหัสผ่านเก่า</label>

        <div class="relative">
          <input
            :type="showOldPassword ? 'text' : 'password'"
            v-model="form.oldPassword"
            class="w-full h-11 sm:h-12 bg-white/40 rounded-2xl px-4 pr-12 text-white"
          />

          <!-- ไอคอนตา -->
          <div
            @click="toggleOldPassword"
            class="absolute right-4 top-1/2 -translate-y-1/2 cursor-pointer"
          >
            <!-- ตาเปิด -->
            <svg
              v-if="showOldPassword"
              xmlns="http://www.w3.org/2000/svg"
              width="22"
              height="22"
              viewBox="0 0 512 512"
              class="text-white/70"
            >
              <circle cx="256" cy="256" r="64" fill="currentColor" />
              <path
                fill="currentColor"
                d="M490.84 238.6c-26.46-40.92-60.79-75.68-99.27-100.53C349 110.55 302 96 255.66 96c-42.52 0-84.33 12.15-124.27 36.11c-40.73 24.43-77.63 60.12-109.68 106.07a31.92 31.92 0 0 0-.64 35.54c26.41 41.33 60.4 76.14 98.28 100.65C162 402 207.9 416 255.66 416c46.71 0 93.81-14.43 136.2-41.72c38.46-24.77 72.72-59.66 99.08-100.92a32.2 32.2 0 0 0-.1-34.76M256 352a96 96 0 1 1 96-96a96.11 96.11 0 0 1-96 96"
              />
            </svg>

            <!-- ตาปิด -->
            <svg
              v-else
              xmlns="http://www.w3.org/2000/svg"
              width="22"
              height="22"
              viewBox="0 0 512 512"
              class="text-white/70"
            >
              <path
                fill="currentColor"
                d="M432 448a15.92 15.92 0 0 1-11.31-4.69l-352-352a16 16 0 0 1 22.62-22.62l352 352A16 16 0 0 1 432 448M248 315.85l-51.79-51.79a2 2 0 0 0-3.39 1.69a64.11 64.11 0 0 0 53.49 53.49a2 2 0 0 0 1.69-3.39m16-119.7L315.87 248a2 2 0 0 0 3.4-1.69a64.13 64.13 0 0 0-53.55-53.55a2 2 0 0 0-1.72 3.39"
              />
              <path
                fill="currentColor"
                d="M491 273.36a32.2 32.2 0 0 0-.1-34.76c-26.46-40.92-60.79-75.68-99.27-100.53C349 110.55 302 96 255.68 96a226.5 226.5 0 0 0-71.82 11.79a4 4 0 0 0-1.56 6.63l47.24 47.24a4 4 0 0 0 3.82 1.05a96 96 0 0 1 116 116a4 4 0 0 0 1.05 3.81l67.95 68a4 4 0 0 0 5.4.24a343.8 343.8 0 0 0 67.24-77.4M256 352a96 96 0 0 1-93.3-118.63a4 4 0 0 0-1.05-3.81l-66.84-66.87a4 4 0 0 0-5.41-.23c-24.39 20.81-47 46.13-67.67 75.72a31.92 31.92 0 0 0-.64 35.54c26.41 41.33 60.39 76.14 98.28 100.65C162.06 402 207.92 416 255.68 416a238.2 238.2 0 0 0 72.64-11.55a4 4 0 0 0 1.61-6.64l-47.47-47.46a4 4 0 0 0-3.81-1.05A96 96 0 0 1 256 352"
              />
            </svg>
          </div>
          <p v-if="errors.oldPassword" class="text-red-400 text-xs mt-1">
            {{ errors.oldPassword }}
          </p>
        </div>
      </div>

      <!-- รหัสผ่านใหม่ -->
      <div class="flex flex-col w-full max-w-[320px] sm:max-w-[363px] gap-1">
        <label class="text-white text-sm font-bold">รหัสผ่านใหม่</label>

        <div class="relative">
          <input
            :type="showNewPassword ? 'text' : 'password'"
            v-model="form.newPassword"
            class="w-full h-11 sm:h-12 bg-white/40 rounded-2xl px-4 pr-12 text-white"
          />

          <div
            @click="toggleNewPassword"
            class="absolute right-4 top-1/2 -translate-y-1/2 cursor-pointer"
          >
            <svg
              v-if="showNewPassword"
              xmlns="http://www.w3.org/2000/svg"
              width="22"
              height="22"
              viewBox="0 0 512 512"
              class="text-white/70"
            >
              <circle cx="256" cy="256" r="64" fill="currentColor" />
              <path
                fill="currentColor"
                d="M490.84 238.6c-26.46-40.92-60.79-75.68-99.27-100.53C349 110.55 302 96 255.66 96c-42.52 0-84.33 12.15-124.27 36.11c-40.73 24.43-77.63 60.12-109.68 106.07a31.92 31.92 0 0 0-.64 35.54c26.41 41.33 60.4 76.14 98.28 100.65C162 402 207.9 416 255.66 416c46.71 0 93.81-14.43 136.2-41.72c38.46-24.77 72.72-59.66 99.08-100.92a32.2 32.2 0 0 0-.1-34.76M256 352a96 96 0 1 1 96-96a96.11 96.11 0 0 1-96 96"
              />
            </svg>

            <svg
              v-else
              xmlns="http://www.w3.org/2000/svg"
              width="22"
              height="22"
              viewBox="0 0 512 512"
              class="text-white/70"
            >
              <path
                fill="currentColor"
                d="M432 448a15.92 15.92 0 0 1-11.31-4.69l-352-352a16 16 0 0 1 22.62-22.62l352 352A16 16 0 0 1 432 448M248 315.85l-51.79-51.79a2 2 0 0 0-3.39 1.69a64.11 64.11 0 0 0 53.49 53.49a2 2 0 0 0 1.69-3.39m16-119.7L315.87 248a2 2 0 0 0 3.4-1.69a64.13 64.13 0 0 0-53.55-53.55a2 2 0 0 0-1.72 3.39"
              />
              <path
                fill="currentColor"
                d="M491 273.36a32.2 32.2 0 0 0-.1-34.76c-26.46-40.92-60.79-75.68-99.27-100.53C349 110.55 302 96 255.68 96a226.5 226.5 0 0 0-71.82 11.79a4 4 0 0 0-1.56 6.63l47.24 47.24a4 4 0 0 0 3.82 1.05a96 96 0 0 1 116 116a4 4 0 0 0 1.05 3.81l67.95 68a4 4 0 0 0 5.4.24a343.8 343.8 0 0 0 67.24-77.4M256 352a96 96 0 0 1-93.3-118.63a4 4 0 0 0-1.05-3.81l-66.84-66.87a4 4 0 0 0-5.41-.23c-24.39 20.81-47 46.13-67.67 75.72a31.92 31.92 0 0 0-.64 35.54c26.41 41.33 60.39 76.14 98.28 100.65C162.06 402 207.92 416 255.68 416a238.2 238.2 0 0 0 72.64-11.55a4 4 0 0 0 1.61-6.64l-47.47-47.46a4 4 0 0 0-3.81-1.05A96 96 0 0 1 256 352"
              />
            </svg>
          </div>
          <p v-if="errors.newPassword" class="text-red-400 text-xs mt-1">
            {{ errors.newPassword }}
          </p>
        </div>
      </div>

      <!-- ยืนยันรหัสผ่านใหม่ -->
      <div class="flex flex-col w-full max-w-[320px] sm:max-w-[363px] gap-1">
        <label class="text-white text-sm font-bold">ยืนยันรหัสผ่านใหม่</label>

        <div class="relative">
          <input
            :type="showConfirmPassword ? 'text' : 'password'"
            v-model="form.confirmPassword"
            class="w-full h-11 sm:h-12 bg-white/40 rounded-2xl px-4 pr-12 text-white"
          />

          <div
            @click="toggleConfirmPassword"
            class="absolute right-4 top-1/2 -translate-y-1/2 cursor-pointer"
          >
            <svg
              v-if="showConfirmPassword"
              xmlns="http://www.w3.org/2000/svg"
              width="22"
              height="22"
              viewBox="0 0 512 512"
              class="text-white/70"
            >
              <circle cx="256" cy="256" r="64" fill="currentColor" />
              <path
                fill="currentColor"
                d="M490.84 238.6c-26.46-40.92-60.79-75.68-99.27-100.53C349 110.55 302 96 255.66 96c-42.52 0-84.33 12.15-124.27 36.11c-40.73 24.43-77.63 60.12-109.68 106.07a31.92 31.92 0 0 0-.64 35.54c26.41 41.33 60.4 76.14 98.28 100.65C162 402 207.9 416 255.66 416c46.71 0 93.81-14.43 136.2-41.72c38.46-24.77 72.72-59.66 99.08-100.92a32.2 32.2 0 0 0-.1-34.76M256 352a96 96 0 1 1 96-96a96.11 96.11 0 0 1-96 96"
              />
            </svg>

            <svg
              v-else
              xmlns="http://www.w3.org/2000/svg"
              width="22"
              height="22"
              viewBox="0 0 512 512"
              class="text-white/70"
            >
              <path
                fill="currentColor"
                d="M432 448a15.92 15.92 0 0 1-11.31-4.69l-352-352a16 16 0 0 1 22.62-22.62l352 352A16 16 0 0 1 432 448M248 315.85l-51.79-51.79a2 2 0 0 0-3.39 1.69a64.11 64.11 0 0 0 53.49 53.49a2 2 0 0 0 1.69-3.39m16-119.7L315.87 248a2 2 0 0 0 3.4-1.69a64.13 64.13 0 0 0-53.55-53.55a2 2 0 0 0-1.72 3.39"
              />
              <path
                fill="currentColor"
                d="M491 273.36a32.2 32.2 0 0 0-.1-34.76c-26.46-40.92-60.79-75.68-99.27-100.53C349 110.55 302 96 255.68 96a226.5 226.5 0 0 0-71.82 11.79a4 4 0 0 0-1.56 6.63l47.24 47.24a4 4 0 0 0 3.82 1.05a96 96 0 0 1 116 116a4 4 0 0 0 1.05 3.81l67.95 68a4 4 0 0 0 5.4.24a343.8 343.8 0 0 0 67.24-77.4M256 352a96 96 0 0 1-93.3-118.63a4 4 0 0 0-1.05-3.81l-66.84-66.87a4 4 0 0 0-5.41-.23c-24.39 20.81-47 46.13-67.67 75.72a31.92 31.92 0 0 0-.64 35.54c26.41 41.33 60.39 76.14 98.28 100.65C162.06 402 207.92 416 255.68 416a238.2 238.2 0 0 0 72.64-11.55a4 4 0 0 0 1.61-6.64l-47.47-47.46a4 4 0 0 0-3.81-1.05A96 96 0 0 1 256 352"
              />
            </svg>
          </div>
          <p v-if="errors.confirmPassword" class="text-red-400 text-xs mt-1">
            {{ errors.confirmPassword }}
          </p>
        </div>
      </div>
    </template>
    <div class="flex flex-col gap-4 mt-4 justify-center items-center">
      <!-- ปุ่ม -->
      <button
        @click="toggleEdit"
        class="w-[150px] sm:w-[170px] h-[40px] sm:h-[44px] bg-[#90CB38] rounded-2xl text-white font-medium text-base sm:text-lg hover:bg-[#7fbb32] cursor-pointer"
      >
        {{ isEditing ? "ยืนยัน" : "แก้ไข" }}
      </button>

      <button
        v-if="isEditing"
        @click="cancelEdit"
        class="w-[120px] h-[40px] sm:h-[44px] bg-red-500 rounded-2xl text-white font-medium hover:bg-red-500/30 cursor-pointer"
      >
        ยกเลิก
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";

const isEditing = ref(false);

const form = ref({
  oldPassword: "",
  newPassword: "",
  confirmPassword: "",
});

const errors = ref({
  oldPassword: "",
  newPassword: "",
  confirmPassword: "",
});

// show / hide password
const showOldPassword = ref(false);
const showNewPassword = ref(false);
const showConfirmPassword = ref(false);

const toggleOldPassword = () =>
  (showOldPassword.value = !showOldPassword.value);
const toggleNewPassword = () =>
  (showNewPassword.value = !showNewPassword.value);
const toggleConfirmPassword = () =>
  (showConfirmPassword.value = !showConfirmPassword.value);

const clearErrors = () => {
  errors.value.oldPassword = "";
  errors.value.newPassword = "";
  errors.value.confirmPassword = "";
};

const toggleEdit = async () => {
  // เปิดโหมดแก้ไข
  if (!isEditing.value) {
    isEditing.value = true;
    clearErrors();
    return;
  }

  clearErrors();
  let hasError = false;

  if (!form.value.oldPassword) {
    errors.value.oldPassword = "กรุณากรอกรหัสผ่านเก่า";
    hasError = true;
  }

  if (!form.value.newPassword) {
    errors.value.newPassword = "กรุณากรอกรหัสผ่านใหม่";
    hasError = true;
  }

  if (!form.value.confirmPassword) {
    errors.value.confirmPassword = "กรุณายืนยันรหัสผ่านใหม่";
    hasError = true;
  }

  if (
    form.value.newPassword &&
    form.value.confirmPassword &&
    form.value.newPassword !== form.value.confirmPassword
  ) {
    errors.value.confirmPassword = "รหัสผ่านใหม่ไม่ตรงกัน";
    hasError = true;
  }

  if (hasError) return;

  try {
    await $fetch("/api/password", {
      method: "PUT",
      body: {
        oldPassword: form.value.oldPassword,
        newPassword: form.value.newPassword,
      },
      credentials: "include",
    });

    // success
    form.value.oldPassword = "";
    form.value.newPassword = "";
    form.value.confirmPassword = "";
    isEditing.value = false;
  } catch (err) {
    errors.value.oldPassword = "รหัสผ่านเก่าไม่ถูกต้อง";
  }
};

const cancelEdit = () => {
  form.value.oldPassword = "";
  form.value.newPassword = "";
  form.value.confirmPassword = "";

  clearErrors();

  showOldPassword.value = false;
  showNewPassword.value = false;
  showConfirmPassword.value = false;

  isEditing.value = false;
};
</script>
