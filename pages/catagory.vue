<template>
  <div class="bg-black mt-22 flex flex-col">
    <section class="relative h-[80vh] w-full overflow-hidden">
      <!-- breadcrumb -->
      <div
        class="absolute z-30 top-6 left-1/3 md:left-1/6 -translate-x-1/2 bg-black/30 rounded"
      >
        <Breadcrumb />
      </div>

      <!-- HERO BACKDROP (crossfade) -->
      <transition name="hero-fade" mode="out-in">
        <img
          v-if="randomHeroMovie"
          :key="randomHeroMovie.id"
          :src="`https://image.tmdb.org/t/p/original${randomHeroMovie.backdrop_path}`"
          class="absolute inset-0 w-full h-full object-cover scale-105 object-top"
        />
      </transition>

      <!-- overlay -->
      <div
        class="absolute inset-0 bg-gradient-to-t from-black via-black/60 to-transparent"
      ></div>
    </section>

    <section
      class="flex flex-col lg:flex-row gap-4 p-4 mb-20 max-w-full lg:max-w-[80%] mx-auto -mt-[42vh] sm:-mt-[38vh] md:-mt-[30vh] lg:mt-0 relative z-20"
    >
      <div
        class="hidden lg:block bg-white/5 backdrop-blur-xl border border-white/10 w-1/4 rounded-xl sticky top-24 self-start"
      >
        <SkeletonCatagorySkeletonSidebarFilter v-if="isLoadingGenres" />
        <div v-else class="w-full p-4 justify-start">
          <h2 class="font-bold text-2xl mb-2 w-full text-start"></h2>

          <div class="relative inline-block text-left w-full p-2">
            <button
              class="px-4 py-3 bg-gradient-to-r from-[#A0E13E] to-lime-400 font-extrabold tracking-wide text-black rounded-lg hover:brightness-110 hover:scale-[1.02] transition flex justify-between items-center w-full cursor-pointer"
              @click="openFillterDrop = !openFillterDrop"
            >
              {{
                categories.find((c) => c.key === currentCategory)?.label ||
                "Filter"
              }}
              <Icon
                icon="weui:arrow-outlined"
                class="ml-1 w-4 h-4 text-white transition-transform duration-200"
                :class="{ 'rotate-90': openFillterDrop }"
              />
            </button>
            <div
              v-if="openFillterDrop"
              class="p-3 mt-3 bg-black/90 border border-white/10 shadow-2xl rounded-xl z-50 flex flex-wrap animate-fade"
            >
              <p class="font-bold text-xl mb-2 w-full text-start text-white">
                ประเภท
              </p>
              <button
                v-for="category in categories"
                :key="category.key"
                class="px-4 py-2 my-1 w-full text-left rounded-md transition-colors"
                :class="
                  currentCategory === category.key
                    ? 'bg-[#A0E13E] text-black font-extrabold shadow-lg'
                    : 'hover:bg-white/10 hover:pl-6 transition-all'
                "
                @click="
                  currentCategory !== category.key &&
                  selectCategory(category.key)
                "
              >
                {{ category.label }}
              </button>
            </div>
          </div>
          <div class="relative inline-block text-left w-full p-2">
            <button
              class="px-4 py-3 bg-gradient-to-r from-[#A0E13E] to-lime-400 font-extrabold tracking-wide text-black rounded-lg hover:brightness-110 hover:scale-[1.02] transition flex justify-between items-center w-full cursor-pointer"
              @click="openStreamimgDrop = !openStreamimgDrop"
            >
              {{ "แท็ก" }}
              <Icon
                icon="weui:arrow-outlined"
                class="ml-1 w-4 h-4 text-white transition-transform duration-200"
                :class="{ 'rotate-90': openStreamimgDrop }"
              />
            </button>
            <div
              v-if="openStreamimgDrop"
              class="p-3 mt-3 bg-black/90 border border-white/10 shadow-2xl rounded-xl z-50 flex flex-wrap animate-fade"
            >
              <Tages
                :genres="movieGenres"
                :selectedGenres="selectedGenres"
                @update:selectedGenres="onGenreChange"
                class="w-full"
              />
            </div>
            <Streaming
              @update="onProviderChange"
              class="p-3 mt-3 bg-black/90 border border-white/10 shadow-2xl rounded-xl z-50 flex flex-wrap animate-fade"
            />
          </div>
        </div>
      </div>

      <div class="flex lg:hidden mb-4">
        <button
          @click="openMobileFilter = true"
          class="w-full py-3 bg-[#A0E13E] text-black font-bold rounded-lg"
        >
          เปิดตัวกรอง
        </button>
      </div>

      <transition name="fade">
        <div
          v-if="openMobileFilter"
          class="fixed inset-0 bg-black/70 z-50 flex items-end"
        >
          <div
            class="bg-[#0E0E0E] w-full rounded-t-2xl p-6 max-h-[80vh] overflow-y-auto custom-scrollbar"
          >
            <div class="flex w-full justify-end">
              <button class="text-white mb-4" @click="openMobileFilter = false">
                ปิด
              </button>
            </div>

            <SkeletonCatagorySkeletonSidebarFilter v-if="isLoadingGenres" />
            <div v-else class="w-full p-4 justify-start">
              <h2 class="font-bold text-2xl mb-2 w-full text-start"></h2>

              <div class="relative inline-block text-left w-full p-2">
                <button
                  class="px-4 py-3 bg-gradient-to-r from-[#A0E13E] to-lime-400 font-extrabold tracking-wide text-black rounded-lg hover:brightness-110 hover:scale-[1.02] transition flex justify-between items-center w-full cursor-pointer"
                  @click="openFillterDrop = !openFillterDrop"
                >
                  {{
                    categories.find((c) => c.key === currentCategory)?.label ||
                    "Filter"
                  }}
                  <Icon
                    icon="weui:arrow-outlined"
                    class="ml-1 w-4 h-4 text-white transition-transform duration-200"
                    :class="{ 'rotate-90': openFillterDrop }"
                  />
                </button>
                <div
                  v-if="openFillterDrop"
                  class="p-3 mt-3 bg-black/90 border border-white/10 shadow-2xl rounded-xl z-50 flex flex-wrap animate-fade"
                >
                  <p
                    class="font-bold text-xl mb-2 w-full text-start text-white"
                  >
                    ประเภท
                  </p>
                  <button
                    v-for="category in categories"
                    :key="category.key"
                    class="px-4 py-2 my-1 w-full text-left rounded-md transition-colors"
                    :class="
                      currentCategory === category.key
                        ? 'bg-[#A0E13E] text-black font-extrabold shadow-lg'
                        : 'hover:bg-white/10 hover:pl-6 transition-all'
                    "
                    @click="
                      currentCategory !== category.key &&
                      selectCategory(category.key)
                    "
                  >
                    {{ category.label }}
                  </button>
                </div>
              </div>
              <div class="relative inline-block text-left w-full p-2">
                <button
                  class="px-4 py-3 bg-gradient-to-r from-[#A0E13E] to-lime-400 font-extrabold tracking-wide text-black rounded-lg hover:brightness-110 hover:scale-[1.02] transition flex justify-between items-center w-full cursor-pointer"
                  @click="openStreamimgDrop = !openStreamimgDrop"
                >
                  {{ "แท็ก" }}
                  <Icon
                    icon="weui:arrow-outlined"
                    class="ml-1 w-4 h-4 text-white transition-transform duration-200"
                    :class="{ 'rotate-90': openStreamimgDrop }"
                  />
                </button>
                <div
                  v-if="openStreamimgDrop"
                  class="p-3 mt-3 bg-black/90 border border-white/10 shadow-2xl rounded-xl z-50 flex flex-wrap animate-fade"
                >
                  <Tages
                    :genres="movieGenres"
                    :selectedGenres="selectedGenres"
                    @update:selectedGenres="onGenreChange"
                    class="w-full"
                  />
                </div>
                <Streaming
                  @update="onProviderChange"
                  class="p-3 mt-3 bg-black/90 border border-white/10 shadow-2xl rounded-xl z-50 flex flex-wrap animate-fade"
                />
              </div>
            </div>
          </div>
        </div>
      </transition>

      <div
        class="bg-gradient-to-b from-[#0E0E0E] to-black text-white w-full lg:w-3/4 flex rounded-2xl border border-white/10 shadow-[0_20px_60px_rgba(0,0,0,0.6)]"
      >
        <section class="w-full p-4">
          <div
            class="flex flex-col sm:flex-row justify-between w-full mb-4 p-2 gap-4"
          >
            <h2
              class="font-extrabold text-2xl sm:text-4xl tracking-wide relative"
            >
              ภาพยนตร์
              <span
                class="block w-8 md:w-16 h-1 bg-[#A0E13E] mt-2 rounded-full"
              ></span>
            </h2>
            <FilterSortbyAZ
              :items="movies"
              keyName="title"
              @update="updateMovies"
              class=""
            />
          </div>
          <div class="border-t border-white/10 mb-6"></div>

          <transition name="fade" mode="out-in">
            <SkeletonCatagorySkeletonMovieList
              v-if="isLoadingMovies"
              :count="20"
            />
            <div
              v-else
              class="grid gap-2 px-4 grid-cols-2 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5"
            >
              <CardM
                v-for="movie in movies"
                :key="movie.id"
                :movie="movie"
                @open="openPopup"
              />
              <div v-for="i in 20" :key="'loading-' + i">
                <SkeletonCatagorySkeletonCard v-if="isLoadingMore" />
              </div>
            </div>
          </transition>
          <PopupM
            v-if="showPopup"
            :selectedId="selectedId"
            @close="showPopup = false"
          />
          <button
            v-if="currentPage < totalPages"
            @click="loadMore"
            class="px-8 py-4 bg-gradient-to-r from-[#A0E13E] to-lime-400 text-black font-extrabold tracking-widest rounded-xl hover:scale-105 hover:shadow-[0_0_30px_#A0E13E55] transition w-full flex justify-center items-center cursor-pointer"
          >
            ดูเพิ่มเติม
          </button>
        </section>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch, onUnmounted, unref, computed } from "vue";
import type { Ref } from "vue";
import type { Movie, Genre } from "../Type/tmdb";
import { useTMDB } from "../composables/useTMDB";
import { useGlobalLoading } from "../composables/useGlobalLoading";

const { start, stop } = useGlobalLoading();
const {
  getPopularMovies,
  getTopRatedMovies,
  getUpcomingMovies,
  getNowPlaying,
  getGenres,
  getMoviesByGenres,
  getMovieProviders,
  discoverMoviesByProviders,
} = useTMDB();
const movies = ref<Array<Movie>>([]);
const movieGenres = ref<Genre[]>([]);
const isLoadingMovies = ref(true);
const isLoadingGenres = ref(true);
const isLoadingMore = ref(false);
const currentPage = ref(1);
const totalPages = ref(1);
const currentCategory = ref("popular");

const categories = [
  { key: "popular", label: "ยอดนิยม" },
  { key: "now_playing", label: "กำลังฉาย" },
  { key: "upcoming", label: "โปรแกรมหน้า" },
  { key: "top_rated", label: "รีวิวสูงสุด" },
];

const getMovies = async (
  category: string,
  genres: number[],
  providers: number[],
  page = 1,
) => {
  let res;

  if (providers.length) {
    let filteredCategory = "";
    if (category === "now_playing") filteredCategory = "now_playing";
    else if (category === "upcoming") filteredCategory = "upcoming";

    res = await discoverMoviesByProviders(
      providers,
      genres, // genre filter
      sortMap[category], // sort
      page,
    );

    // กรองผลลัพธ์ตาม Category ภายใน frontend
    if (filteredCategory === "now_playing") {
      res.results = res.results.filter(
        (movie) => new Date(movie.release_date) <= new Date(),
      );
    } else if (filteredCategory === "upcoming") {
      res.results = res.results.filter(
        (movie) => new Date(movie.release_date) > new Date(),
      );
    }
  } else if (genres.length) {
    // มีแค่ Genre → ใช้ discover แบบไม่ส่ง providers
    res = await discoverMoviesByProviders([], genres, sortMap[category], page);
  } else {
    switch (category) {
      case "popular":
        res = await getPopularMovies(page);
        break;
      case "now_playing":
        res = await getNowPlaying(page);
        break;
      case "upcoming":
        res = await getUpcomingMovies(page);
        break;
      case "top_rated":
        res = await getTopRatedMovies(page);
        break;
      default:
        res = await getPopularMovies(page);
    }
  }

  totalPages.value = res?.total_pages ?? 1;
  return res;
};

const selectCategory = async (key: string) => {
  start();
  isLoadingMovies.value = true;

  try {
    currentCategory.value = key;
    selectedGenres.value = [];
    currentPage.value = 1;

    const res = await getMovies(
      key,
      selectedGenres.value,
      selectedProviders.value,
      currentPage.value,
    );

    movies.value = res?.results ?? [];
  } finally {
    isLoadingMovies.value = false;
    stop();
  }
};

// โหลด default category
onMounted(async () => {
  start();
  isLoadingMovies.value = true;
  isLoadingGenres.value = true;

  try {
    await selectCategory(currentCategory.value);

    const res = await getGenres();
    if (res) movieGenres.value = res.genres;
  } finally {
    isLoadingMovies.value = false;
    isLoadingGenres.value = false;
    stop();
  }
});

const selectedGenres = ref<number[]>([]);

const onGenreChange = async (newGenres: number[]) => {
  selectedGenres.value = newGenres;
  currentPage.value = 1;
  isLoadingMovies.value = true;

  start();

  try {
    const res = await getMovies(
      currentCategory.value,
      selectedGenres.value,
      selectedProviders.value,
      currentPage.value,
    );
    movies.value = res?.results ?? [];
  } finally {
    isLoadingMovies.value = false;
    stop();
  }
};

const openFillterDrop = ref(true);
const openStreamimgDrop = ref(false);

const showPopup = ref(false);
const selectedId = ref(null);

function openPopup(id) {
  selectedId.value = id;
  showPopup.value = true;
}

watch(showPopup, (val) => {
  document.body.style.overflow = val ? "hidden" : "";
});

const handleEsc = (e) => {
  if (e.key === "Escape") showPopup.value = false;
};
onMounted(() => {
  document.addEventListener("keydown", handleEsc);
});

onUnmounted(() => {
  document.removeEventListener("keydown", handleEsc);
  document.body.style.cursor = "default";
  document.body.style.overflow = "";
});

async function loadMore() {
  if (currentPage.value >= totalPages.value || isLoadingMore.value) return;

  start();

  try {
    const nextPage = currentPage.value + 1;

    const res = await getMovies(
      currentCategory.value,
      selectedGenres.value,
      selectedProviders.value,
      nextPage,
    );

    if (res?.results?.length) {
      const existingIds = new Set(movies.value.map((m) => m.id));
      const newMovies = res.results.filter((m) => !existingIds.has(m.id));

      if (newMovies.length) {
        movies.value.push(...newMovies);
        currentPage.value = nextPage;
      }
    }
  } finally {
    stop();
  }
}
const selectedProviders = ref<number[]>([]);

function onProviderChange(providers: number[]) {
  selectedProviders.value = providers;
  currentPage.value = 1;
  isLoadingMovies.value = true;

  getMovies(
    currentCategory.value,
    selectedGenres.value,
    selectedProviders.value,
    currentPage.value,
  ).then((res) => {
    movies.value = res?.results ?? [];
    isLoadingMovies.value = false;
  });
}

const sortMap = {
  popular: "popularity.desc",
  top_rated: "vote_average.desc",
  upcoming: "release_date.desc",
  now_playing: "primary_release_date.desc",
};

function updateMovies(sorted: Movie[] | Ref<Movie[]>) {
  movies.value = Array.isArray(unref(sorted)) ? unref(sorted) : [];
}

function handleSearchMovie(movie) {
  selectedId.value = movie.id;
  showPopup.value = true;
}

import { useRoute } from "vue-router";

const route = useRoute();

const genreId = computed(() => Number(route.query.genre));
const genreName = computed(() => route.query.name);

watch(
  () => route.query.genre,
  async (genre) => {
    if (!genre) {
      openStreamimgDrop.value = false;
      return;
    }

    openStreamimgDrop.value = true;
    selectedGenres.value = [Number(genre)];
    currentPage.value = 1;
    isLoadingMovies.value = true;
    start();

    try {
      const res = await getMovies(
        currentCategory.value,
        selectedGenres.value,
        selectedProviders.value,
        currentPage.value,
      );
      movies.value = res?.results ?? [];
    } finally {
      isLoadingMovies.value = false;
      stop();
    }
  },
  { immediate: true },
);

const selectedGenreId = computed(() => Number(route.query.genre || null));

const heroSeed = ref(0);

watch(movies, () => {
  heroSeed.value++;
});

const randomHeroMovie = computed(() => {
  if (!movies.value.length) return null;

  const withBackdrop = movies.value.filter((m) => m.backdrop_path);
  if (!withBackdrop.length) return null;

  const index = heroSeed.value % withBackdrop.length;
  return withBackdrop[index];
});

// ==== mobilefulter ===
const openMobileFilter = ref(false);

// === ปิด scroll พิ้นหลัง mobilefillter ===
watch(openMobileFilter, (val) => {
  if (val) {
    document.body.style.overflow = "hidden";
  } else {
    document.body.style.overflow = "";
  }
});
</script>

<style>
@keyframes fade {
  from {
    opacity: 0;
    transform: translateY(-5px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
.animate-fade {
  animation: fade 0.15s ease-in-out;
}
.fade-enter-from {
  opacity: 0;
}
.fade-enter-to {
  opacity: 1;
}
.fade-enter-active {
  transition: opacity 0.3s ease;
}
</style>
