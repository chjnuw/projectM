<template>
  <div class="">
    <section class="snap-start">
      <Slide />
    </section>

    <section class="lg:my-10">
      <div
        class="px-4 sm:px-6 lg:px-0 max-w-[90%] lg:max-w-[80%] xl:max-w-[70%] mx-auto"
      >
        <div class="snap-start mb-10 lg:mb-16">
          <div
            v-if="!isLoggedIn"
            class="justify-center items-center flex flex-col p-6 gap-4"
          >
            <p class="text-sm text-gray-400 px-4">
              เข้าสู่ระบบเพื่อเลือกแนวหนังที่คุณชอบ
            </p>
            <button
              @click="goToLogin"
              class="px-8 py-3 bg-[#90CB38] text-white rounded-xl"
            >
              เข้าสู่ระบบ
            </button>
          </div>

          <!-- ✅ login แล้ว -->
          <template v-else>
            <div
              class="mb-4 flex flex-col md:flex-row md:items-center gap-2 md:gap-3"
            >
              <h2
                class="font-bold text-xl sm:text-2xl whitespace-normal sm:whitespace-nowrap"
              >
                แนะนำสำหรับคุณ
              </h2>
              <p class="text-gray-500 text-xs md:text-sm">
                จากแนวหนังที่คุณชื่นชอบ
              </p>
              <div class="hidden md:block flex-1 border-b-2"></div>
            </div>

            <div
              v-if="userTags.length"
              class="flex flex-col md:flex-row md:items-center justify-between gap-4"
            >
              <div
                class="flex gap-2 flex-wrap text-sm max-w-full overflow-hidden"
              >
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

            <!-- ⚠️ login แต่ยังไม่มี tag -->
            <div
              v-else
              class="flex flex-col items-center justify-center px-4 py-6 gap-4 text-center"
            >
              <p class="text-sm text-gray-400 px-4 text-center">
                คุณยังไม่ได้เลือกแนวหนังที่คุณชอบ
              </p>
            </div>
          </template>
        </div>

        <div
          v-if="isLoggedIn && userGender === 1"
          class="snap-start mb-10 lg:mb-16"
        >
          <div class="flex items-center gap-3 mb-4">
            <h2
              class="font-bold text-xl sm:text-2xl whitespace-normal sm:whitespace-nowrap"
            >
              ภาพยนตร์ตามแนวรสนิยมของผู้ชาย ♂️
            </h2>
            <div class="hidden md:block flex-1 border-b-2"></div>
          </div>
          <div
            class="flex flex-col sm:flex-row sm:items-center sm:justify-end gap-4"
          >
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
                @click="genderSortMode = 'popular'"
                :class="[
                  'flex-1 sm:flex-none px-3 py-1.5 text-xs sm:text-sm rounded-full transition-all duration-200 active:scale-95',
                  genderSortMode === 'popular'
                    ? 'bg-green-600 text-white shadow'
                    : 'text-gray-400 hover:text-white cursor-pointer',
                ]"
              >
                นิยม
              </button>

              <button
                @click="genderSortMode = 'rating'"
                :class="[
                  'flex-1 sm:flex-none px-3 py-1.5 text-xs sm:text-sm rounded-full transition-all duration-200 active:scale-95',
                  genderSortMode === 'rating'
                    ? 'bg-green-600 text-white shadow'
                    : 'text-gray-400 hover:text-white cursor-pointer',
                ]"
              >
                เรทคะแนน
              </button>
            </div>
          </div>
          <GenderRecommend
            title="แนะนำสำหรับผู้ชาย"
            endpoint="/api/recommend/male"
            :gender-sort-mode="genderSortMode"
            @open="openPopup"
          />
        </div>

        <div
          v-if="isLoggedIn && userGender === 2"
          class="snap-start mb-10 lg:mb-16"
        >
          <div class="flex items-center gap-3 mb-4">
            <h2
              class="font-bold text-xl sm:text-2xl whitespace-normal sm:whitespace-nowrap"
            >
              ภาพยนตร์ตามแนวรสนิยมของผู้หญิง ♀️
            </h2>
            <div class="hidden md:block flex-1 border-b-2"></div>
          </div>
          <div
            class="flex flex-col sm:flex-row sm:items-center sm:justify-end gap-4"
          >
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
                @click="genderSortMode = 'popular'"
                :class="[
                  'flex-1 sm:flex-none px-3 py-1.5 text-xs sm:text-sm rounded-full transition-all duration-200 active:scale-95',
                  genderSortMode === 'popular'
                    ? 'bg-green-600 text-white shadow'
                    : 'text-gray-400 hover:text-white cursor-pointer',
                ]"
              >
                นิยม
              </button>

              <button
                @click="genderSortMode = 'rating'"
                :class="[
                  'flex-1 sm:flex-none px-3 py-1.5 text-xs sm:text-sm rounded-full transition-all duration-200 active:scale-95',
                  genderSortMode === 'rating'
                    ? 'bg-green-600 text-white shadow'
                    : 'text-gray-400 hover:text-white cursor-pointer',
                ]"
              >
                เรทคะแนน
              </button>
            </div>
          </div>
          <GenderRecommend
            title="แนะนำสำหรับผู้หญิง"
            endpoint="/api/recommend/female"
            :gender-sort-mode="genderSortMode"
            @open="openPopup"
          />
        </div>

        <div
          v-if="isLoggedIn && userGender === 3"
          class="snap-start mb-10 lg:mb-16"
        >
          <div class="flex items-center gap-3 mb-4">
            <h2
              class="font-bold text-xl sm:text-2xl whitespace-normal sm:whitespace-nowrap"
            >
              แนวภาพยนตร์ที่เพศอื่นๆ ชื่นชอบ ⚥
            </h2>
            <div class="hidden md:block flex-1 border-b-2"></div>
          </div>
          <div
            class="flex flex-col sm:flex-row sm:items-center sm:justify-end gap-4"
          >
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
                @click="genderSortMode = 'popular'"
                :class="[
                  'flex-1 sm:flex-none px-3 py-1.5 text-xs sm:text-sm rounded-full transition-all duration-200 active:scale-95',
                  genderSortMode === 'popular'
                    ? 'bg-green-600 text-white shadow'
                    : 'text-gray-400 hover:text-white cursor-pointer',
                ]"
              >
                นิยม
              </button>

              <button
                @click="genderSortMode = 'rating'"
                :class="[
                  'flex-1 sm:flex-none px-3 py-1.5 text-xs sm:text-sm rounded-full transition-all duration-200 active:scale-95',
                  genderSortMode === 'rating'
                    ? 'bg-green-600 text-white shadow'
                    : 'text-gray-400 hover:text-white cursor-pointer',
                ]"
              >
                เรทคะแนน
              </button>
            </div>
          </div>
          <GenderRecommend
            title="แนะนำยอดนิยม"
            endpoint="/api/recommend/female"
            :gender-sort-mode="genderSortMode"
            @open="openPopup"
          />
        </div>

        <!-- <div v-if="isNoLoggedIn" class="snap-start mb-10">
        <div class="p-4 flex items-center gap-3">
          <h2 class="font-bold text-2xl whitespace-nowrap">หนังยอดนิยม</h2>
          <div class="flex-1 border-b-2"></div>
        </div>
        <PopularM @open="openPopup" />
      </div> -->
      </div>
    </section>
  </div>
  <PopupM
    v-if="showPopup && selectedId !== null"
    :selectedId="selectedId"
    @close="showPopup = false"
  />
</template>
<script setup lang="ts">
import { ref, onMounted, watchEffect, watch, onActivated } from "vue";
import { $fetch } from "ofetch";
import { computed } from "vue";
import { useRouter } from "vue-router";

type UserTag = {
  id: number;
  name: string;
  created_at: string;
  state?: "stable" | "new" | "fading";
};

const userTags = ref<UserTag[]>([]);

onMounted(async () => {
  try {
    const me = await $fetch("/api/me");
    isLoggedIn.value = true;
    // isNoLoggedIn.value = false;
    userGender.value = Number(me.gender);

    const tags = await $fetch<UserTag[]>("/api/user/tags");
    syncUserTags(tags);

    moviesMale.value = await $fetch("/api/recommend/male");
    moviesFemale.value = await $fetch("/api/recommend/female");
  } catch (e) {
    isLoggedIn.value = false;
    // isNoLoggedIn.value = true;
    userTags.value = [];
  }
});

const router = useRouter();
const isLoggedIn = ref(false);
// const isNoLoggedIn = ref(true);
const userGender = ref<number | null>(null);

const goToLogin = () => {
  router.push("/logInscreen");
};

const showPopup = ref(false);
const selectedId = ref<number | null>(null);

const openPopup = (id: number) => {
  selectedId.value = id;
  showPopup.value = true;
};

const emit = defineEmits<{
  (e: "open", id: number): void;
}>();

const moviesMale = ref([]);
const moviesFemale = ref([]);

const tastePieRef = ref<any>(null);

const onFavoriteChanged = () => {
  tastePieRef.value?.refreshTaste();
};

import { useTasteProfile } from "../composables/useTasteProfile";
const topGenreId = ref<number | null>(null);
const topMood = ref<string | null>(null);

const syncUserTags = (updatedTags: UserTag[]) => {
  const oldMap = new Map(previousTags.value.map(t => [t.id, t]));
  const newMap = new Map(updatedTags.map(t => [t.id, t]));

  const added: string[] = [];
  const removed: string[] = [];

  // หา tag ที่เพิ่ม
  for (const [id, tag] of newMap) {
    if (!oldMap.has(id)) {
      added.push(tag.name);
    }
  }

  // หา tag ที่ลบ
  for (const [id, tag] of oldMap) {
    if (!newMap.has(id)) {
      removed.push(tag.name);
    }
  }

  // สร้างข้อความ
  let message = "";

  if (added.length) {
    message += `เพิ่ม ${added.map(t => `#${t}`).join(", ")}`;
  }

  if (removed.length) {
    if (message) message += " | ";
    message += `ลบ ${removed.map(t => `#${t}`).join(", ")}`;
  }

  tagChangeMessage.value = message;

  // อัปเดตของจริง
  userTags.value = updatedTags;
};

const sortMode = ref<"default" | "popular" | "rating">("default");
const genderSortMode = ref<"default" | "popular" | "rating">("default");

const tagChangeMessage = ref("");
let timeout: any = null;

const reloadTags = async () => {
  previousTags.value = JSON.parse(JSON.stringify(userTags.value));
  const updated = await $fetch<UserTag[]>("/api/user/tags");

  syncUserTags(updated);
};

onActivated(() => {
  if (isLoggedIn.value) {
    reloadTags(); // 🔥 โหลดใหม่ตอนกลับมาหน้านี้
  }
});

const previousTags = ref<UserTag[]>([]);
</script>

<style>
.tag-enter-active,
.tag-leave-active {
  transition: all 0.25s ease;
}

.tag-enter-from {
  opacity: 0;
  transform: translateY(6px) scale(0.95);
}

.tag-leave-to {
  opacity: 0;
  transform: scale(0.9);
}
</style>
