<template>
  <div class="">
    <section class="snap-start">
      <Slide />
    </section>

    <section class="my-20 max-w-[80%] mx-auto">
      <div class="snap-start mb-10">
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
          <h2 class="font-bold text-2xl md:text-3xl">
            แนะนำภาพยนตร์ตามรสนิยมของผู้ใช้งาน
          </h2>

          <div
            class="p-4 flex flex-col md:flex-row md:items-center gap-2 md:gap-3"
          >
            <h2 class="font-bold text-xl md:text-2xl">แนะนำสำหรับคุณ</h2>
            <p class="text-gray-500 text-xs md:text-sm">
              จากแนวหนังที่คุณชื่นชอบ
            </p>
            <div class="hidden md:block flex-1 border-b-2"></div>
          </div>

          <div
            v-if="userTags.length"
            class="flex flex-col md:flex-row md:items-center justify-between gap-4"
          >
            <div class="flex gap-2 flex-wrap text-sm">
              <TransitionGroup name="tag">
                <span
                  v-for="tag in userTags"
                  :key="tag.id"
                  class="px-3 py-1 rounded-full bg-green-600/20 text-green-400 border border-green-500/20"
                >
                  # {{ tag.name }}
                </span>
              </TransitionGroup>
            </div>

            <div
              class="flex bg-white/5 backdrop-blur rounded-full p-1 border border-white/10"
            >
              <button
                @click="sortMode = 'popular'"
                :class="[
                  'px-4 py-1.5 text-sm rounded-full transition-all duration-300',
                  sortMode === 'popular'
                    ? 'bg-green-600 text-white shadow-md'
                    : 'text-gray-400 hover:text-white cursor-pointer',
                ]"
              >
                นิยม
              </button>

              <button
                @click="sortMode = 'rating'"
                :class="[
                  'px-4 py-1.5 text-sm rounded-full transition-all duration-300',
                  sortMode === 'rating'
                    ? 'bg-green-600 text-white shadow-md'
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
            class="justify-center items-center flex flex-col p-6 gap-4"
          >
            <p class="text-sm text-gray-400 px-4">
              คุณยังไม่ได้เลือกแนวหนังที่คุณชอบ
            </p>
          </div>
        </template>
      </div>

      <div v-if="isLoggedIn && userGender === 1" class="snap-start mb-10">
        <div class="p-4 flex items-center gap-3">
          <h2 class="font-bold text-2xl whitespace-nowrap">
            ภาพยนตร์ตามแนวรสนิยมของผู้ชาย ♂️
          </h2>
          <div class="hidden md:block flex-1 border-b-2"></div>
        </div>
        <div class="flex md:flex-row md:items-center justify-end gap-4">
          <div
            class="flex bg-white/5 backdrop-blur rounded-full p-1 border border-white/10"
          >
            <button
              @click="genderSortMode = 'popular'"
              :class="[
                'px-4 py-1.5 text-sm rounded-full transition-all duration-300',
                genderSortMode === 'popular'
                  ? 'bg-green-600 text-white shadow-md'
                  : 'text-gray-400 hover:text-white',
              ]"
            >
              นิยม
            </button>

            <button
              @click="genderSortMode = 'rating'"
              :class="[
                'px-4 py-1.5 text-sm rounded-full transition-all duration-300',
                genderSortMode === 'rating'
                  ? 'bg-green-600 text-white shadow-md'
                  : 'text-gray-400 hover:text-white',
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

      <div v-if="isLoggedIn && userGender === 2" class="snap-start mb-10">
        <div class="p-4 flex items-center gap-3">
          <h2 class="font-bold text-2xl whitespace-nowrap">
            ภาพยนตร์ตามแนวรสนิยมของผู้หญิง ♀️
          </h2>
          <div class="hidden md:block flex-1 border-b-2"></div>
        </div>
        <div class="flex md:flex-row md:items-center justify-end gap-4">
          <div
            class="flex bg-white/5 backdrop-blur rounded-full p-1 border border-white/10"
          >
            <button
              @click="genderSortMode = 'popular'"
              :class="[
                'px-4 py-1.5 text-sm rounded-full transition-all duration-300',
                genderSortMode === 'popular'
                  ? 'bg-green-600 text-white shadow-md'
                  : 'text-gray-400 hover:text-white',
              ]"
            >
              นิยม
            </button>

            <button
              @click="genderSortMode = 'rating'"
              :class="[
                'px-4 py-1.5 text-sm rounded-full transition-all duration-300',
                genderSortMode === 'rating'
                  ? 'bg-green-600 text-white shadow-md'
                  : 'text-gray-400 hover:text-white',
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

      <div v-if="isLoggedIn && userGender === 3" class="snap-start mb-10">
        <div class="p-4 flex items-center gap-3">
          <h2 class="font-bold text-2xl whitespace-nowrap">
            แนวภาพยนตร์ที่เพศอื่นๆ ชื่นชอบ ⚥
          </h2>
          <div class="hidden md:block flex-1 border-b-2"></div>
        </div>
        <div class="flex md:flex-row md:items-center justify-end gap-4">
          <div
            class="flex bg-white/5 backdrop-blur rounded-full p-1 border border-white/10"
          >
            <button
              @click="genderSortMode = 'popular'"
              :class="[
                'px-4 py-1.5 text-sm rounded-full transition-all duration-300',
                genderSortMode === 'popular'
                  ? 'bg-green-600 text-white shadow-md'
                  : 'text-gray-400 hover:text-white',
              ]"
            >
              นิยม
            </button>

            <button
              @click="genderSortMode = 'rating'"
              :class="[
                'px-4 py-1.5 text-sm rounded-full transition-all duration-300',
                genderSortMode === 'rating'
                  ? 'bg-green-600 text-white shadow-md'
                  : 'text-gray-400 hover:text-white',
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
    </section>
  </div>
  <PopupM
    v-if="showPopup && selectedId !== null"
    :selectedId="selectedId"
    @close="showPopup = false"
  />
</template>
<script setup lang="ts">
import { ref, onMounted, watchEffect } from "vue";
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

const syncUserTags = (nextTags: UserTag[]) => {
  const currentMap = new Map(userTags.value.map((t) => [t.id, t]));
  const nextMap = new Map(nextTags.map((t) => [t.id, t]));

  const merged: UserTag[] = [];

  // tag ที่ยังอยู่ + tag ใหม่
  for (const tag of nextTags) {
    if (currentMap.has(tag.id)) {
      merged.push({
        ...tag,
        state: "stable",
      });
    } else {
      const newTag: UserTag = {
        ...tag,
        state: "new",
      };
      merged.push(newTag);

      // new → stable
      setTimeout(() => {
        newTag.state = "stable";
      }, 1200);
    }
  }

  // tag ที่ถูกลบ
  for (const old of userTags.value) {
    if (!nextMap.has(old.id)) {
      const fading: UserTag = {
        ...old,
        state: "fading",
      };
      merged.push(fading);

      setTimeout(() => {
        userTags.value = userTags.value.filter((t) => t.id !== old.id);
      }, 300);
    }
  }

  userTags.value = merged;
};

const sortMode = ref<"popular" | "rating">("popular");
const genderSortMode = ref<"popular" | "rating">("popular");
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
