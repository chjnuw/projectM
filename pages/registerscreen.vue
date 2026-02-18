<template>
  <div class="relative w-full min-h-screen flex justify-center items-center">
    <div
      class="absolute inset-0 bg-[url('/img/bglogin2.webp')] bg-cover bg-center"
    ></div>
    <div class="absolute inset-0 bg-black/50"></div>
    <!-- LOGO : ซ้ายบนเสมอ -->
    <img
      src="/img/logo.png"
      alt="logo"
      class="absolute top-4 left-4 z-20 w-[120px] sm:w-[180px] md:w-[240px] lg:w-[300px] drop-shadow-2xl hidden md:flex"
    />

    <div
      class="relative z-10 w-full max-w-md mx-4 bg-white/80 backdrop-blur-md rounded-3xl shadow-2xl p-6 sm:p-8"
    >
      <div class="w-full h-full flex flex-col items-center gap-4">
        <h1 class="text-2xl sm:text-4xl font-bold text-gray-900 text-center">
          สมัครสมาชิก
        </h1>

        <h2 class="text-sm sm:text-base text-gray-700 text-center">
          สมัครสมาชิกเพื่อเริ่มต้นการเดินทางในโลกภาพยนตร์ของคุณ!
        </h2>
        <!-- =================== ชื่อผู้ใช้ =================== -->
        <div class="flex flex-col w-full">
          <div
            class="w-full h-[48px] flex items-center bg-white rounded-full px-4 shadow-sm"
          >
            <div class="flex items-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 512 512"
                class="ml-2.5 text-[#737373]"
              >
                <path
                  fill="currentColor"
                  d="M256 42.667A213.333 213.333 0 0 1 469.334 256c0 117.821-95.513 213.334-213.334 213.334c-117.82 0-213.333-95.513-213.333-213.334C42.667 138.18 138.18 42.667 256 42.667m21.334 234.667h-42.667c-52.815 0-98.158 31.987-117.715 77.648c30.944 43.391 81.692 71.685 139.048 71.685s108.104-28.294 139.049-71.688c-19.557-45.658-64.9-77.645-117.715-77.645M256 106.667c-35.346 0-64 28.654-64 64s28.654 64 64 64s64-28.654 64-64s-28.653-64-64-64"
                />
              </svg>

              <input
                type="text"
                placeholder="ชื่อผู้ใช้"
                v-model="form.name"
                class="flex-1 p-3 bg-transparent focus:outline-none text-black font-extrabold text-shadow-2xl"
              />
            </div>
          </div>
          <p
            v-if="errors.name"
            class="text-red-600 text-xs mt-0.5 ml-6 text-shadow-5xl"
          >
            {{ errors.name }}
          </p>
        </div>
        <!-- =================== อีเมล =================== -->
        <div class="flex flex-col w-full">
          <div
            class="w-full h-[48px] flex items-center bg-white rounded-full px-4 shadow-sm"
          >
            <div class="flex items-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="22"
                height="22"
                viewBox="0 0 20 20"
                class="ml-2.5 text-[#737373]"
              >
                <path
                  fill="currentColor"
                  d="m7.172 11.334l2.83 1.935l2.728-1.882l6.115 6.033q-.242.079-.512.08H1.667c-.22 0-.43-.043-.623-.12zM20 6.376v9.457c0 .247-.054.481-.15.692l-5.994-5.914zM0 6.429l6.042 4.132l-5.936 5.858A1.7 1.7 0 0 1 0 15.833zM18.333 2.5c.92 0 1.667.746 1.667 1.667v.586L9.998 11.648L0 4.81v-.643C0 3.247.746 2.5 1.667 2.5z"
                />
              </svg>

              <input
                type="text"
                placeholder="อีเมล"
                v-model="form.email"
                class="flex-1 p-3 bg-transparent focus:outline-none text-black font-extrabold text-shadow-2xl"
              />
            </div>
          </div>
          <p v-if="errors.email" class="text-red-600 text-xs mt-0.5 ml-6">
            {{ errors.email }}
          </p>
        </div>
        <!-- =================== เพศ =================== -->
        <div class="flex flex-col w-full">
          <div class="flex justify-around text-gray-700 text-sm">
            <label class="flex items-center gap-2">
              <input type="radio" value="1" v-model="form.gender" />
              ชาย
            </label>

            <label class="flex items-center gap-2">
              <input type="radio" value="2" v-model="form.gender" />
              หญิง
            </label>

            <label class="flex items-center gap-2">
              <input type="radio" value="3" v-model="form.gender" />
              อื่นๆ
            </label>
          </div>
        </div>
        <!-- วันเดือนปีเกิด -->
        <div class="flex flex-col w-full">
          <div
            class="w-full h-[48px] flex items-center bg-white rounded-full px-4 shadow-sm"
          >
            <div class="flex items-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="22"
                height="22"
                viewBox="0 0 24 24"
                class="ml-2.5 text-[#737373]"
              >
                <path
                  fill="currentColor"
                  d="M7 10h5v5H7zm7 0h3v5h-3zM7 3v2H5a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2V3h-2v2H9V3zm12 16H5V9h14z"
                />
              </svg>
              <input
                type="text"
                :value="age ? `${age} ปี` : ''"
                readonly
                placeholder="วันเดือนปีเกิด"
                class="flex-1 p-3 bg-transparent focus:outline-none text-black font-bold"
              />
            </div>
          </div>
          <p v-if="errors.birthdate" class="text-red-600 text-xs mt-0.5 ml-6">
            {{ errors.birthdate }}
          </p>
        </div>
        <!-- อายุ  -->
        <div
          class="w-full h-[48px] flex items-center bg-white rounded-full px-4 opacity-80 shadow-sm"
        >
          <div class="flex items-center">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="22"
              height="22"
              viewBox="0 0 24 24"
              class="ml-2.5 text-[#737373]"
            >
              <path
                fill="currentColor"
                d="M12 2a10 10 0 1 0 10 10A10.01
         10.01 0 0 0 12 2m1 15h-2v-6h2zm0-8h-2V7h2z"
              />
            </svg>

            <input
              type="text"
              :value="age ? `${age} ปี` : ''"
              disabled
              placeholder="อายุ"
              class="flex-1 p-3 bg-transparent focus:outline-none text-black font-extrabold text-shadow-2xl cursor-not-allowed"
            />
          </div>
        </div>
        <!-- =================== รหัสผ่าน =================== -->
        <div class="flex flex-col w-full">
          <div
            class="w-full h-[50px] flex items-center bg-white rounded-full px-4 shadow-sm"
          >
            <div class="flex items-center w-full">
              <!-- icon -->
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="22"
                height="22"
                viewBox="0 0 256 256"
                class="text-[#737373] ml-2.5 shrink-0"
              >
                <path
                  fill="currentColor"
                  d="M208 80h-32V56a48 48 0 0 0-96 0v24H48a16 16 0 0 0-16 16v112a16 16 0 0 0 16 16h160a16 16 0 0 0 16-16V96a16 16 0 0 0-16-16m-72 78.63V184a8 8 0 0 1-16 0v-25.37a24 24 0 1 1 16 0M160 80H96V56a32 32 0 0 1 64 0Z"
                />
              </svg>

              <!-- input -->
              <input
                :type="showPassword ? 'text' : 'password'"
                v-model="form.password"
                placeholder="รหัสผ่าน"
                autocomplete="new-password"
                inputmode="text"
                class="flex-1 bg-transparent focus:outline-none text-black font-bold text-base px-3 placeholder-gray-500"
              />
            </div>

            <!-- eye -->
            <button type="button" @click="togglePassword" class="ml-2 shrink-0">
              <svg
                v-if="showPassword"
                xmlns="http://www.w3.org/2000/svg"
                width="22"
                height="22"
                viewBox="0 0 512 512"
                class="text-[#737373]"
              >
                <circle cx="256" cy="256" r="64" fill="currentColor" />
              </svg>

              <svg
                v-else
                xmlns="http://www.w3.org/2000/svg"
                width="22"
                height="22"
                viewBox="0 0 512 512"
                class="text-[#737373]"
              >
                <path fill="currentColor" d="M432 448l-352-352" />
              </svg>
            </button>
          </div>

          <p v-if="errors.password" class="text-red-600 text-xs mt-1 ml-6">
            {{ errors.password }}
          </p>
        </div>
        <button
          type="button"
          :disabled="loading || !acceptTerms"
          class="w-full h-[48px] bg-[#A0E13E] hover:bg-[#78aa2d] text-white rounded-full font-bold shadow-lg disabled:opacity-50"
          @click="gototag"
        >
          {{ loading ? "กำลังโหลด..." : "ถัดไป" }}
        </button>

        <!-- Terms & Conditions -->
        <div class="mt-3 ml-1">
          <label class="flex items-start gap-2 text-sm text-gray-700">
            <input
              type="checkbox"
              v-model="acceptTerms"
              class="mt-1 cursor-pointer"
            />

            <span>
              ฉันยอมรับ
              <button
                type="button"
                class="text-[#A0E13E] font-semibold hover:text-[#78aa2d] cursor-pointer underline ml-1"
                @click="showPolicy = true"
              >
                นโยบายความเป็นส่วนตัว
              </button>
            </span>
          </label>

          <p v-if="errors.acceptTerms" class="text-red-600 text-xs mt-1 ml-6">
            {{ errors.acceptTerms }}
          </p>
        </div>

        <div
          class="flex flex-col sm:flex-row items-center justify-center gap-1 sm:gap-3 mt-4 text-center"
        >
          <p class="text-xs sm:text-sm text-gray-800">มีบัญชีอยู่แล้วใช่ไหม?</p>

          <button
            type="button"
            class="text-[#A0E13E] font-semibold hover:text-[#78aa2d] transition"
            @click="gotoLogin"
          >
            เข้าสู่ระบบ
          </button>
        </div>
      </div>
    </div>
  </div>
  <div
    v-if="showPolicy"
    class="fixed inset-0 bg-black/50 flex items-center justify-center z-50"
  >
    <div class="bg-white rounded-xl w-[90%] max-w-lg p-6 relative">
      <h2 class="text-lg font-bold mb-3">นโยบายความเป็นส่วนตัว</h2>

      <div
        class="text-sm text-gray-700 space-y-2 max-h-[300px] overflow-y-auto"
      >
        <p>
          เว็บไซต์นี้จะเก็บข้อมูลส่วนบุคคล เช่น ชื่อ อีเมล เพศ และวันเกิด
          เพื่อใช้ในการสมัครสมาชิกและให้บริการเท่านั้น
        </p>
        <p>
          ข้อมูลของคุณจะไม่ถูกเปิดเผยแก่บุคคลภายนอก
          เว้นแต่เป็นไปตามที่กฎหมายกำหนด
        </p>
      </div>

      <div class="flex justify-end mt-4">
        <button
          class="px-4 py-2 bg-[#A0E13E] hover:bg-[#78aa2d] text-white rounded-lg cursor-pointer"
          @click="showPolicy = false"
        >
          ปิด
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: "guest",
});
import { ref, watch, onMounted } from "vue";
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.css";
import { Thai } from "flatpickr/dist/l10n/th.js";
// form
const form = ref({
  name: "",
  email: "",
  password: "",
  gender: "",
  birthdate: "",
  age: null,
});
const acceptTerms = ref(false);
const errors = ref({
  name: "",
  email: "",
  password: "",
  gender: "",
  birthdate: "",
  acceptTerms: "",
});
const validatePassword = (password) => {
  const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,10}$/;
  return regex.test(password);
};
const validateEmail = (email) => {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
};

const validateForm = () => {
  let valid = true;

  // reset error
  Object.keys(errors.value).forEach((k) => (errors.value[k] = ""));

  if (!form.value.name) {
    errors.value.name = "กรุณากรอกชื่อผู้ใช้";
    valid = false;
  }

  if (!form.value.email) {
    errors.value.email = "กรุณากรอกอีเมล";
    valid = false;
  } else if (!validateEmail(form.value.email)) {
    errors.value.email = "รูปแบบอีเมลไม่ถูกต้อง";
    valid = false;
  }

  if (!form.value.password) {
    errors.value.password = "กรุณากรอกรหัสผ่าน";
    valid = false;
  } else if (!validatePassword(form.value.password)) {
    errors.value.password =
      "รหัสผ่านต้องมีอย่างน้อย 8 ตัวแต่ไม่เกิน10ตัว และประกอบด้วย A-Z, a-z และตัวเลข";
    valid = false;
  }

  if (!form.value.gender) {
    errors.value.gender = "กรุณาเลือกเพศ";
    valid = false;
  }

  if (!form.value.birthdate) {
    errors.value.birthdate = "กรุณาเลือกวันเกิด";
    valid = false;
  } else {
    //  เช็กอายุขั้นต่ำ 10 ปี
    const birth = new Date(form.value.birthdate);
    const today = new Date();

    let age = today.getFullYear() - birth.getFullYear();
    const m = today.getMonth() - birth.getMonth();

    if (m < 0 || (m === 0 && today.getDate() < birth.getDate())) {
      age--;
    }

    if (age < 10) {
      errors.value.birthdate = "ต้องมีอายุอย่างน้อย 10 ปี";
      valid = false;
    }
  }
  if (!acceptTerms.value) {
    errors.value.acceptTerms = "กรุณายอมรับเงื่อนไขก่อนสมัคร";
    valid = false;
  }
  return valid;
};
const showPolicy = ref(false);
// age
const age = ref(null);
// flatpickr ref
const birthInput = ref(null);
onMounted(() => {
  const today = new Date();
  const maxDate = new Date(
    today.getFullYear() - 10,
    today.getMonth(),
    today.getDate(),
  );

  flatpickr(birthInput.value, {
    locale: Thai,
    dateFormat: "d/m/Y",
    disableMobile: true,
    maxDate, // ✅ สำคัญ

    onChange: (selectedDates) => {
      if (!selectedDates[0]) {
        form.value.birthdate = "";
        return;
      }

      const d = selectedDates[0];
      const y = d.getFullYear();
      const m = String(d.getMonth() + 1).padStart(2, "0");
      const day = String(d.getDate()).padStart(2, "0");

      form.value.birthdate = `${y}-${m}-${day}`;
    },
  });
});
// watch birthdate → คำนวณอายุ
// --------------------
watch(
  () => form.value.birthdate,
  (newDate) => {
    if (!newDate) {
      age.value = null;
      return;
    }

    const birth = new Date(`${newDate}T00:00:00`);
    if (isNaN(birth)) return;

    const today = new Date();
    let years = today.getFullYear() - birth.getFullYear();

    const m = today.getMonth() - birth.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birth.getDate())) {
      years--;
    }

    age.value = years;
    form.value.age = years;
  },
);
// password toggle
// --------------------
const showPassword = ref(false);
const togglePassword = () => {
  showPassword.value = !showPassword.value;
};
// register
// --------------------
const loading = ref(false);
const errorMsg = ref("");
const gototag = async () => {
  if (loading.value) return;

  if (!validateForm()) return;

  loading.value = true;

  try {
    const res = await $fetch("/api/register", {
      method: "POST",
      body: form.value,
    });

    if (!res.ok) {
      // 👇 map error กลับไปที่ field
      if (res.field && errors.value[res.field] !== undefined) {
        errors.value[res.field] = res.message;
      } else {
        alert(res.message || "Register failed");
      }
      return;
    }

    if (res.ok && res.userId !== undefined) {
      navigateTo(`/verify-email?email=${form.value.email}`);
    }
  } catch (err) {
    console.error(err);
    alert("API error");
  } finally {
    loading.value = false;
  }
};
const gotoLogin = () => {
  navigateTo("/logInscreen");
};
</script>

<style></style>
