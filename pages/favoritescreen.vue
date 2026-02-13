<template>
  <div class="z-40 mx-[10%] mt-22">
    <Breadcrumb />
  </div>
  <!-- ⏳ loading -->
  <div
    v-if="pending"
    class="w-full min-h-screen bg-[#0B0A0A] flex items-center justify-center"
  >
    <h1 class="text-white">Loading...</h1>
  </div>

  <!-- ❌ not login -->
  <div
    v-else-if="!isLoggedIn"
    class="w-full min-h-screen bg-[#0B0A0A] flex items-center justify-center"
  >
    <div class="flex flex-col items-center gap-6 text-center">
      <h1 class="text-white text-2xl">คุณยังไม่ได้ล็อกอินบัญชีผู้ใช้</h1>

      <button
        @click="goToLogin"
        class="px-8 py-3 bg-[#90CB38] text-white rounded-xl hover:bg-[#6da11f]"
      >
        เข้าสู่ระบบ
      </button>
    </div>
  </div>

  <!-- ✅ logged in -->
  <div
    v-else
    class="w-full max-w-[1200px] mx-auto bg-[#0B0A0A] m-4 px-4 rounded-2xl mb-10 p-10"
  >
    <!-- HEADER -->
    <div class="grid grid-cols-1 md:grid-cols-3 items-center gap-4 pt-6">
      <div class="hidden md:block"></div>
      <!-- title -->
      <h1 class="text-2xl md:text-3xl font-medium text-center px-4 py-2">
        รายการโปรด
      </h1>

      <!-- ปุ่มซ้าย (จอใหญ่) -->
      <div class="hidden md:flex justify-end">
        <button
          @click="openFavPopup"
          class="px-4 py-2 bg-[#90CB38] hover:bg-[#699627] rounded-2xl text-white cursor-pointer"
        >
          สุ่มหนังจากรายการโปรด
        </button>
      </div>

      <!-- balance -->
      <div class="hidden md:block"></div>

      <!-- ปุ่มมือถือ -->
      <div class="flex md:hidden justify-center">
        <button
          @click="openFavPopup"
          class="w-full max-w-[240px] h-[45px] bg-[#90CB38] hover:bg-[#699627] rounded-2xl text-white"
        >
          สุ่มหนังจากรายการโปรด
        </button>
      </div>
    </div>

    <!-- LIST -->
    <div class="mt-6 pb-16 text-white mx-6">
      <transition name="fade" mode="out-in">
        <SkeletonCatagorySkeletonMovieList v-if="isLoadingMovies" :count="20" />

        <div
          v-else-if="movies.length"
          class="grid gap-4 grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6"
        >
          <CardM
            v-for="movie in movies"
            :key="movie.id"
            :movie="movie"
            @removed="removeMovie"
            @open="openPopup"
          />
        </div>

        <p v-else class="text-center text-gray-500 mt-10">
          ยังไม่มีหนังในรายการโปรด
        </p>
      </transition>
    </div>

    <!-- recommend -->
    <div class="mt-10 mb-10 px-2">
      <div
        class="mb-4 flex flex-col md:flex-row md:items-center gap-2 md:gap-3"
      >
        <h2
          class="font-bold text-xl sm:text-2xl whitespace-normal sm:whitespace-nowrap"
        >
          แนะนำสำหรับคุณ
        </h2>
        <p class="text-gray-500 text-xs md:text-sm">จากแนวหนังที่คุณชื่นชอบ</p>
        <div class="hidden md:block flex-1 border-b-2"></div>
      </div>

      <div
        v-if="userTags.length"
        class="flex flex-col md:flex-row md:items-center justify-between gap-4"
      >
        <div class="flex gap-2 flex-wrap text-sm max-w-full overflow-hidden">
          <TransitionGroup name="tag">
            <span
              v-for="tag in userTags"
              :key="tag.id"
              class="px-2.5 py-1 rounded-full bg-green-600/20 text-green-400 border border-green-500/20"
            >
              # {{ tag.name }}
            </span>
          </TransitionGroup>
        </div>

        <div
          class="flex w-full sm:w-auto bg-white/5 backdrop-blur rounded-full p-1 border border-white/10"
        >
          <button
            @click="sortMode = 'default'"
            :class="[
              'flex-1 sm:flex-none px-3 py-1.5 text-xs sm:text-sm rounded-full transition-all duration-200 active:scale-95',
              sortMode === 'default'
                ? 'bg-green-600 text-white shadow'
                : 'text-gray-400 hover:text-white cursor-pointer',
            ]"
          >
            แนะนำ
          </button>

          <button
            @click="sortMode = 'popular'"
            :class="[
              'flex-1 sm:flex-none px-3 py-1.5 text-xs sm:text-sm rounded-full transition-all duration-200 active:scale-95',
              sortMode === 'popular'
                ? 'bg-green-600 text-white shadow'
                : 'text-gray-400 hover:text-white cursor-pointer',
            ]"
          >
            นิยม
          </button>

          <button
            @click="sortMode = 'rating'"
            :class="[
              'flex-1 sm:flex-none px-3 py-1.5 text-xs sm:text-sm rounded-full transition-all duration-200 active:scale-95',
              sortMode === 'rating'
                ? 'bg-green-600 text-white shadow'
                : 'text-gray-400 hover:text-white cursor-pointer',
            ]"
          >
            เรทคะแนน
          </button>
        </div>
      </div>

      <!-- 🎬 มี tag → แนะนำ -->
      <Recomment
        v-if="userTags.length"
        :sort-mode="sortMode"
        @open="openPopup"
      />
    </div>
    <!-- <TastePie /> -->
  </div>
  <!-- popup movie -->
  <PopupM
    v-if="showPopup && selectedId !== null"
    :selectedId="selectedId"
    @close="showPopup = false"
  />

  <!-- popup fav -->
  <Popupfav
    v-if="showFavPopup"
    @close="showFavPopup = false"
    @result="openResult"
  />

  <PopupResultFav
    v-if="resultMovie"
    :movie="resultMovie"
    @close="resultMovie = null"
    @view="openMovieDetail"
    @retry="retrySpin"
  />
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from "vue";
import { useRouter } from "vue-router";
import type { Movie } from "../Type/tmdb";
import { useTMDB } from "../composables/useTMDB";

/* router */
const router = useRouter();

const sortMode = ref<"popular" | "rating">("popular");

/* login */
const { pending, error } = await useFetch("/api/profile", {
  credentials: "include",
  throw: false,
});

const isLoggedIn = computed(() => !pending.value && !error.value);

const goToLogin = () => {
  router.push("/logInscreen");
};

/* movies */
const movies = ref<Movie[]>([]);
const isLoadingMovies = ref(true);

/* popup movie */
const showPopup = ref(false);
const selectedId = ref<number | null>(null);

const openPopup = (id: number) => {
  selectedId.value = id;
  showPopup.value = true;
};

const removeMovie = (id: number) => {
  movies.value = movies.value.filter((m) => m.id !== id);
};

/* popup fav */
const showFavPopup = ref(false);
const resultMovie = ref<Movie | null>(null);

const openFavPopup = () => {
  showFavPopup.value = true;
};

const openResult = (movie: Movie) => {
  resultMovie.value = movie;
  showFavPopup.value = false;
};

const retrySpin = () => {
  resultMovie.value = null;
  showFavPopup.value = true;
};

const openMovieDetail = (id: number) => {
  resultMovie.value = null;
  openPopup(id);
};

/* user tags */
const userTags = ref<{ id: number; name: string }[]>([]);

/* TMDB */
const { getMovieDetails } = useTMDB();

const loadFavorites = async () => {
  isLoadingMovies.value = true;
  try {
    const favs = await $fetch<{ movie_id: number }[]>("/api/favorite", {
      credentials: "include",
    });

    const results = await Promise.all(
      favs.map((f) => getMovieDetails(f.movie_id)),
    );

    movies.value = results.filter(Boolean) as Movie[];
  } catch {
    movies.value = [];
  } finally {
    isLoadingMovies.value = false;
  }
};

/* esc */
const handleEsc = (e: KeyboardEvent) => {
  if (e.key === "Escape") showPopup.value = false;
};

onMounted(async () => {
  await loadFavorites();

  try {
    userTags.value = await $fetch("/api/user/tags", {
      credentials: "include",
    });
  } catch {
    userTags.value = [];
  }

  document.addEventListener("keydown", handleEsc);
});

onUnmounted(() => {
  document.removeEventListener("keydown", handleEsc);
});
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
