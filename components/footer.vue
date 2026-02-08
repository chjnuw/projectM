<template>
  <footer
    class="relative text-gray-300 border-t border-gray-800 bg-gradient-to-b from-[#0b0b0b] via-black to-[#0b0b0b]"
  >
    <!-- Scroll to top -->
    <button
      class="fixed right-6 bottom-6 bg-gray-800 hover:bg-gray-700 text-white p-4 rounded-full shadow-lg transition-all duration-300 z-50"
      :class="[
        buttonOnTop === 'show'
          ? 'opacity-100 translate-y-0 transition-all duration-500 '
          : 'opacity-0 translate-y-10 pointer-events-none ',
      ]"
      @click="OnTop"
    >
      <font-awesome-icon
        icon="fa-solid fa-arrow-up"
        class="transition-transform duration-500"
        :class="buttonOnTop === 'show' ? 'rotate-0' : 'rotate-180'"
      />
    </button>

    <!-- Content -->
    <div class="max-w-7xl mx-auto px-6 py-12 grid gap-8 md:grid-cols-3">
      <!-- Brand -->
      <div
        class="justify-center items-center flex flex-col border-r border-gray-800 md:pr-6"
      >
        <img
          src="/img/logo.png"
          alt="MovieGuie Logo"
          class="mb-4 w-28 h-28 drop-shadow-[0_0_20px_rgba(144,203,56,0.15)]"
        />
        <p
          class="text-sm text-gray-400 text-center md:text-left mb-4 border-l-2 border-[#90CB38] pl-3"
        >
          ค้นพบรสนิยมการดูหนังที่คุณชื่นชอบ
        </p>

        <button
          v-if="!isLoggedIn"
          @click="goToLogin"
          class="relative px-6 sm:px-8 py-2.5 sm:py-3 rounded-xl font-medium bg-gradient-to-r from-[#90CB38] to-[#6da11f] text-black shadow-lg shadow-[#90CB38]/20 hover:shadow-[#90CB38]/40 hover:-translate-y-0.5 transition-all duration-300"
        >
          เริ่มต้นใช้งาน
        </button>
      </div>

      <!-- Links -->
      <div
        class="border-r border-gray-800 md:pr-6 justify-center flex flex-col"
      >
        <h3 class="text-white font-semibold mb-3">สำรวจ</h3>
        <ul class="space-y-2 text-sm">
          <li
            class="group cursor-pointer flex items-center gap-2 transition-all duration-300"
          >
            <span
              class="w-1.5 h-1.5 rounded-full bg-[#90CB38] opacity-0 group-hover:opacity-100 transition"
            />
            <span
              class="group-hover:text-white group-hover:translate-x-1 transition"
            >
              หน้าหลัก
            </span>
          </li>
          <li
            class="group cursor-pointer flex items-center gap-2 transition-all duration-300"
          >
            <span
              class="w-1.5 h-1.5 rounded-full bg-[#90CB38] opacity-0 group-hover:opacity-100 transition"
            />
            <span
              class="group-hover:text-white group-hover:translate-x-1 transition"
            >
              หมวดหมู่
            </span>
          </li>
          <li
            class="group cursor-pointer flex items-center gap-2 transition-all duration-300"
          >
            <span
              class="w-1.5 h-1.5 rounded-full bg-[#90CB38] opacity-0 group-hover:opacity-100 transition"
            />
            <span
              class="group-hover:text-white group-hover:translate-x-1 transition"
            >
              นักแสดง
            </span>
          </li>
          <li
            class="group cursor-pointer flex items-center gap-2 transition-all duration-300"
          >
            <span
              class="w-1.5 h-1.5 rounded-full bg-[#90CB38] opacity-0 group-hover:opacity-100 transition"
            />
            <span
              class="group-hover:text-white group-hover:translate-x-1 transition"
            >
              สุ่มภาพยนตร์
            </span>
          </li>
          <li
            class="group cursor-pointer flex items-center gap-2 transition-all duration-300"
          >
            <span
              class="w-1.5 h-1.5 rounded-full bg-[#90CB38] opacity-0 group-hover:opacity-100 transition"
            />
            <span
              class="group-hover:text-white group-hover:translate-x-1 transition"
            >
              รายการโปรด
            </span>
          </li>
        </ul>
      </div>

      <!-- Credit -->
      <div class="text-sm text-gray-400 flex flex-col gap-2">
        <div class="flex items-center gap-2">
          <span class="opacity-70">Powered by</span>
          <span class="font-semibold text-white">TMDB API</span>
        </div>

        <div class="flex items-center gap-2">
          <span class="opacity-70">Built with</span>
          <span class="font-semibold text-white">Nuxt 3</span>
        </div>

        <p class="mt-4 text-xs opacity-50">© 2026 MovieGuie</p>
      </div>
    </div>
  </footer>
</template>
<script setup>
import { ref, onMounted, onUnmounted } from "vue";
import { useRouter } from "vue-router";

const router = useRouter();

const user = useState("user", () => null);

const { data, pending, error } = await useFetch("/api/profile", {
  credentials: "include",
  throw: false, // สำคัญมาก
});

//  logic เดียว
const isLoggedIn = computed(() => {
  if (pending.value) return false;
  if (error.value) return false;
  return true;
});
let lastScroll = 0;
const buttonOnTop = ref("hidden");

const handleScroll = () => {
  const currentScroll = window.scrollY;

  if (currentScroll <= 50) {
    buttonOnTop.value = "hidden";
    lastScroll = currentScroll;
    return;
  }

  if (currentScroll < lastScroll) {
    // กำลังเลื่อนขึ้น
    buttonOnTop.value = "show";
  } else {
    // กำลังเลื่อนลง
    buttonOnTop.value = "hidden";
  }

  lastScroll = currentScroll;
};
onMounted(() => {
  window.addEventListener("scroll", handleScroll);
});

onUnmounted(() => {
  window.removeEventListener("scroll", handleScroll);
});

const OnTop = () => {
  window.scrollTo({ top: 0, behavior: "smooth" });
};

const goToLogin = () => {
  router.push("/logInscreen");
};
</script>
