<template>
  <!-- NAVBAR -->
  <nav
    :class="[
      'fixed top-0 left-0 w-full z-40 transition-all duration-300',
      navState === 'transparent'
        ? 'bg-gradient-to-t from-transparent to-black/70 translate-y-0'
        : navState === 'hidden'
          ? '-translate-y-full'
          : 'bg-black/100 translate-y-0',
    ]"
  >
    <div
      class="flex justify-evenly items-center h-15 lg:h-20 px-4 sm:px-6 lg:px-10 text-white"
    >
      <!-- LEFT -->
      <div class="flex items-center gap-4">
        <!-- Mobile hamburger -->
        <button class="lg:hidden" @click="mobileMenu = true">
          <Icon icon="heroicons:bars-3" class="w-6 h-6" />
        </button>

        <!-- Logo -->
        <img
          src="/img/logo.png"
          alt="Logo"
          class="w-24 sm:w-28 lg:w-32 object-contain"
        />

        <!-- Desktop menu -->
        <ul class="hidden lg:flex gap-6 text-lg">
          <li :class="menuClass('/')">
            <NuxtLink to="/">หน้าหลัก</NuxtLink>
          </li>
          <li :class="menuClass('/catagory')">
            <NuxtLink to="/catagory">หมวดหมู่</NuxtLink>
          </li>
          <li :class="menuClass('/actor')">
            <NuxtLink to="/actor">นักแสดง</NuxtLink>
          </li>
          <li :class="menuClass('/randomscreen')">
            <NuxtLink to="/randomscreen">สุ่มภาพยนตร์</NuxtLink>
          </li>
        </ul>
      </div>

      <!-- RIGHT -->
      <div class="flex items-center gap-4">
        <!-- Search (desktop) -->
        <button @click="openSearch = true">
          <FontAwesomeIcon
            icon="fa-solid fa-magnifying-glass"
            class="text-sm sm:text-lg lg:text-xl"
          />
        </button>

        <!-- Favorite -->
        <NuxtLink to="/favoritescreen">
          <FontAwesomeIcon
            icon="fa-solid fa-heart"
            class="text-sm sm:text-lg lg:text-xl"
          />
        </NuxtLink>

        <!-- Profile -->
        <NuxtLink to="/profile">
          <img
            v-if="avatar"
            :src="avatar"
            class="w-9 h-9 rounded-full object-cover border border-white/20"
          />

          <div
            v-else-if="userName"
            class="w-9 h-9 rounded-full flex items-center justify-center font-bold uppercase text-white border border-white/20"
            :class="avatarBg"
          >
            {{ userInitial }}
          </div>

          <FontAwesomeIcon
            v-else
            icon="fa-regular fa-circle-user"
            class="text-3xl"
          />
        </NuxtLink>
      </div>
    </div>
  </nav>

  <!-- MOBILE MENU -->
  <transition name="slide">
    <div
      v-show="mobileMenu"
      class="fixed inset-0 z-[998] bg-black/80 backdrop-blur-sm"
    >
      <div class="w-[40vh] bg-black h-full flex flex-col gap-6 text-white px-4 py-2">
        <div class="flex justify-between items-center">
          <img
            src="/img/logo.png"
            alt="Logo"
            class="w-24 sm:w-28 lg:w-32 object-contain"
          />
          <button class="text-xl" @click="mobileMenu = false">
            ✕
          </button>
        </div>

        <NuxtLink to="/" :class="menuClass('/')" @click="mobileMenu = false"
          >หน้าหลัก</NuxtLink
        >
        <NuxtLink
          to="/catagory"
          :class="menuClass('/catagory')"
          @click="mobileMenu = false"
          >หมวดหมู่</NuxtLink
        >
        <NuxtLink
          to="/actor"
          :class="menuClass('/actor')"
          @click="mobileMenu = false"
          >นักแสดง</NuxtLink
        >
        <NuxtLink
          to="/randomscreen"
          :class="menuClass('/randomscreen')"
          @click="mobileMenu = false"
        >
          สุ่มภาพยนตร์
        </NuxtLink>
      </div>

      <div class="flex-1" @click="mobileMenu = false"></div>
    </div>
  </transition>

  <!-- SEARCH OVERLAY -->
  <transition name="search-fade">
    <div
      v-show="openSearch"
      class="fixed inset-0 z-[999] bg-black/95 backdrop-blur-sm flex flex-col"
    >
      <button
        class="absolute top-6 right-6 text-white text-2xl"
        @click="openSearch = false"
      >
        ✕
      </button>

      <div class="mt-40 max-w-2xl mx-auto w-full px-6">
        <MovieSearch
          autofocus
          ref="searchRef"
          @select="onSelectSearchMovie"
          @close="openSearch = false"
          @image-search="openSearch = false"
        />
      </div>
    </div>
  </transition>

  <!-- POPUP -->
  <PopupM
    v-if="showPopup"
    :selectedId="selectedId"
    class="z-50"
    @close="showPopup = false"
  />
</template>

<script setup lang="ts">
import { ref, watch, onMounted, onUnmounted, nextTick, computed } from "vue";
import { useRoute } from "vue-router";
import { useGlobalLoading } from "../composables/useGlobalLoading";

const route = useRoute();
const { start } = useGlobalLoading();

const navState = ref("black");
const mobileMenu = ref(false);
const openSearch = ref(false);
const showPopup = ref(false);
const selectedId = ref(null);
const searchRef = ref(null);

let lastScroll = 0;

/* ---------------- SCROLL CONTROL ---------------- */
watch(
  () => route.path,
  (path) => {
    navState.value = path === "/" ? "transparent" : "black";
  },
  { immediate: true },
);

const handleScroll = () => {
  const current = window.scrollY;

  if (route.path !== "/") {
    navState.value = current > lastScroll ? "hidden" : "black";
    lastScroll = current;
    return;
  }

  if (current <= 50) navState.value = "transparent";
  else if (current > lastScroll) navState.value = "hidden";
  else navState.value = "black";

  lastScroll = current;
};

onMounted(() => {
  window.addEventListener("scroll", handleScroll);
  document.addEventListener("keydown", handleEsc);
});
onUnmounted(() => {
  window.removeEventListener("scroll", handleScroll);
  document.removeEventListener("keydown", handleEsc);
});

/* ---------------- ESC ---------------- */
const handleEsc = (e: KeyboardEvent) => {
  if (e.key !== "Escape") return;

  if (showPopup.value) showPopup.value = false;
  else if (openSearch.value) openSearch.value = false;
  else if (mobileMenu.value) mobileMenu.value = false;
};

/* ---------------- SEARCH SELECT ---------------- */
const onSelectSearchMovie = async (movie: any) => {
  if (!movie?.id) return;
  openSearch.value = false;
  await nextTick();
  start();
  selectedId.value = movie.id;
  showPopup.value = true;
};

/* ---------------- BODY LOCK ---------------- */
watch([mobileMenu, openSearch], ([m, s]) => {
  document.body.style.overflow = m || s ? "hidden" : "";
});

/* ---------------- USER ---------------- */
const user = useUser();

const avatar = computed(() => user.value?.image || null);
const userName = computed(() => user.value?.username || null);
const userInitial = computed(() =>
  userName.value ? userName.value.charAt(0) : "",
);

const avatarColors = [
  "bg-red-400",
  "bg-orange-400",
  "bg-yellow-400",
  "bg-green-400",
  "bg-cyan-400",
  "bg-blue-400",
  "bg-purple-400",
  "bg-pink-400",
];

const avatarBg = computed(() => {
  if (!userName.value) return "bg-gray-400";
  let hash = 0;
  for (let i = 0; i < userName.value.length; i++) {
    hash = userName.value.charCodeAt(i) + ((hash << 5) - hash);
  }
  return avatarColors[Math.abs(hash) % avatarColors.length];
});

/* ---------------- ACTIVE MENU ---------------- */
const menuClass = (path: string) => [
  "hover:text-lime-400 transition duration-300 cursor-pointer",
  route.path === path ? "text-lime-400" : "",
];
</script>

<style>
nav {
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

/* Search fade */
.search-fade-enter-from {
  opacity: 0;
}
.search-fade-enter-to {
  opacity: 1;
}
.search-fade-enter-active {
  transition: opacity 0.35s ease;
}
.search-fade-leave-from {
  opacity: 1;
}
.search-fade-leave-to {
  opacity: 0;
}
.search-fade-leave-active {
  transition: opacity 0.25s ease;
}

/* Mobile slide */
.slide-enter-from {
  transform: translateX(-100%);
}
.slide-enter-to {
  transform: translateX(0);
}
.slide-enter-active {
  transition: transform 0.3s ease;
}
.slide-leave-from {
  transform: translateX(0);
}
.slide-leave-to {
  transform: translateX(-100%);
}
.slide-leave-active {
  transition: transform 0.25s ease;
}
</style>
