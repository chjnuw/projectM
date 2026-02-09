<template>
  <div class="bg-black mt-22">
    <div class="z-40 mx-[10%]">
      <Breadcrumb />
    </div>
    <div
      class="bg-gradient-to-b from-[#0E0E0E] to-black text-white h-full flex flex-wrap justify-center rounded-xl max-w-[80%] mx-auto mb-20 m-4 border border-white/10 backdrop-blur-md"
    >
      <h2
        class="font-extrabold text-3xl md:text-4xl text-center mt-8 tracking-wide"
      >
        นักแสดงยอดนิยม
      </h2>

      <section class="w-full p-4 justify-center mb-10 ">
        <div class="w-full flex justify-center mt-4">
          <div class="relative w-full max-w-lg group">
            <input
              v-model="keyword"
              type="text"
              placeholder="ค้นหานักแสดง เช่น Tom Cruise, Emma Stone..."
              class="w-full px-5 py-3 pr-12 rounded-full bg-black/70 backdrop-blur border border-white/20 text-white placeholder-white/40 focus:outline-none focus:border-[#A0E13E] transition"
            />
            <Transition name="fade-scale">
              <!-- icon search -->
              <span
                v-if="!keyword"
                class="absolute right-4 top-1/2 -translate-y-1/2 text-white/40"
              >
                <FontAwesomeIcon
                  icon="fa-solid fa-magnifying-glass"
                  class="cursor-pointer"
                />
              </span>
         
            <!-- ปุ่มล้าง -->
              <button
                v-else
                @click="clearSearch"
                class="absolute right-4 top-1/2 -translate-y-1/2 text-white/40 hover:text-[#A0E13E] transition"
              >
                ✕
              </button>
            </Transition>
          </div>
        </div>

        <div class="flex w-full justify-center">
          <div
            @click="emit('click')"
            v-if="loading || actors.length"
            class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-2 px-2 sm:px-4 pt-6 w-full max-w-[1500px] mx-auto"
          >
            <template v-if="loading">
              <SkeletonActSkeletonActorCard
                v-for="n in 10"
                :key="'skeleton-' + n"
              />
            </template>
            <template v-else>
              <CardAct
                v-for="actor in actors"
                :key="actor.id"
                loading="lazy"
                @click="openActorPopup(actor)"
                :img="
                  actor.profile_path
                    ? 'https://image.tmdb.org/t/p/w300' + actor.profile_path
                    : 'img/no-profile.png'
                "
                :name="actor.name"
                :gender="actor.gender"
                :department="actor.department"
                class="border border-white/10 rounded-xl hover:scale-[1.05] hover:border-[#A0E13E]/50 transition-all duration-300 cursor-pointer"
              />
            </template>
          </div>
        </div>

        <div class="w-full flex justify-center mt-10">
          <button
            v-if="hasMore"
            @click="loadActors"
            :disabled="loading"
            class="px-8 py-3 rounded-full bg-gradient-to-r from-[#A0E13E] to-lime-400 text-black font-extrabold tracking-wide hover:scale-105 transition disabled:opacity-50 cursor-pointer"
          >
            <span v-if="!loading">โหลดเพิ่ม</span>
            <span v-else>กำลังโหลด...</span>
          </button>
        </div>
        <p
          v-if="!loading && actors.length === 0"
          class="text-center text-white/40 mt-10"
        >
          ไม่พบนักแสดงที่ตรงกับการค้นหา
        </p>
      </section>
    </div>
    <PopupA v-if="showPopup" :actor="selectedActor" @close="closePopup" />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from "vue";
import { useTMDB } from "../composables/useTMDB";
import { useGlobalLoading } from "../composables/useGlobalLoading";

const showPopup = ref(false);
const selectedActor = ref<any>(null);
const emit = defineEmits(["click"]);

const openActorPopup = (actor: any) => {
  selectedActor.value = actor;
  showPopup.value = true;
};

const closePopup = () => {
  showPopup.value = false;
  selectedActor.value = null;
};

const { getPopularActorsEN, searchActorsEN } = useTMDB();

const actors = ref<any[]>([]);
const page = ref(1);
const loading = ref(false);
const hasMore = ref(true);
const keyword = ref("");
const isSearching = ref(false);

const genderMap: Record<number, string> = {
  0: "ไม่ระบุ",
  1: "เพศหญิง",
  2: "เพศชาย",
  3: "Non-binary",
};

const mapActors = (results: any[]) =>
  results.map((actor) => ({
    id: actor.id,
    name: actor.name,
    profile_path: actor.profile_path,
    gender: genderMap[actor.gender] ?? "ไม่ระบุ",
    department: actor.known_for_department,
  }));

const loadActors = async () => {
  if (loading.value) return;
  loading.value = true;

  const res = isSearching.value
    ? await searchActorsEN(keyword.value, page.value)
    : await getPopularActorsEN(page.value);

  const results = res?.results ?? [];

  if (results.length === 0) {
    hasMore.value = false;
    loading.value = false;
    return;
  }

  actors.value.push(...mapActors(results));
  hasMore.value = res.page < res.total_pages;
  page.value++;
  loading.value = false;
};

const searchActors = async () => {
  loading.value = true;
  isSearching.value = true;
  page.value = 1;
  actors.value = [];

  const res = await searchActorsEN(keyword.value, page.value);

  actors.value = mapActors(res.results ?? []);
  hasMore.value = res.page < res.total_pages;
  page.value++;
  loading.value = false;
};

const resetActors = () => {
  isSearching.value = false;
  actors.value = [];
  page.value = 1;
  hasMore.value = true;
};

const debounceTimer = ref<number | null>(null);

watch(keyword, (val) => {
  if (debounceTimer.value) {
    clearTimeout(debounceTimer.value);
  }

  debounceTimer.value = window.setTimeout(async () => {
    actors.value = [];
    page.value = 1;
    hasMore.value = true;

    if (!val.trim()) {
      isSearching.value = false;
      await loadActors(); // popular
    } else {
      isSearching.value = true;
      await loadActors(); // search
    }
  }, 500);
});

const clearSearch = () => {
  keyword.value = "";
};

onMounted(loadActors);
</script>

<style>
.fade-scale-enter-active,
.fade-scale-leave-active {
  transition: all 0.18s ease;
}

.fade-scale-enter-from,
.fade-scale-leave-to {
  opacity: 0;
  transform: scale(0.85);
}
</style>
