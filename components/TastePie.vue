<template>
  <div
    class="mt-20 mx-auto max-w-3xl rounded-3xl bg-gradient-to-b from-[#121212] to-[#0B0A0A] border border-white/10 p-8 shadow-xl"
  >
    <div class="flex justify-end mb-4">
      <div class="relative">
        <select
          v-model="selectedMonth"
          class="appearance-none bg-black/40 text-white text-sm px-6 py-2.5 pr-12 min-w-[190px] rounded-full border border-white/70 text-center cursor-pointer focus:outline-none focus:ring-2 focus:ring-[#90CB38]/60"
        >
          <option v-for="m in availableMonths" :key="m.value" :value="m.value">
            {{ m.label }}
          </option>
        </select>

        <!-- custom arrow -->
        <span
          class="pointer-events-none absolute right-4 top-1/2 -translate-y-1/2 text-white/80 text-xs"
        >
          ▼
        </span>
      </div>
    </div>
    <p v-if="trend" class="text-center text-sm text-white/60 mt-4 italic">
      {{ trend }}
    </p>
    <!-- title -->
    <h2 class="text-white text-xl font-semibold text-center mb-1">
      รสนิยมการดูหนังของคุณ
    </h2>

    <p class="text-white/50 text-sm text-center mb-6">
      วิเคราะห์จากหนังที่คุณกด ❤️
    </p>

    <!-- loading -->
    <p v-if="pending" class="text-white/60 text-center py-20">
      ⏳ กำลังประมวลผลรสนิยมของคุณ...
    </p>

    <!-- empty (โหลดเสร็จแล้วจริง ๆ และไม่มีข้อมูล) -->
    <p
      v-else-if="data && data.length === 0"
      class="text-white/60 text-center py-20"
    >
      ยังไม่มีข้อมูลรสนิยม <br />
      <span class="text-xs text-white/40">
        ลองกดเพิ่มหนังในรายการโปรดก่อนนะ 🙂
      </span>
    </p>
    <!-- chart -->

    <div
      v-if="isClientReady && data?.length"
      class="relative mx-auto h-[360px] max-w-[520px]"
    >
      <canvas ref="canvasRef" />
    </div>

    <div v-if="topGenres.length" class="text-center mb-4">
      <p class="text-white/60 text-sm mb-2">แนวที่คุณชอบที่สุด</p>

      <div class="flex flex-wrap justify-center gap-3">
        <div
          v-for="g in topGenres"
          :key="g.genre_id"
          @click="goToCategory(g.genre_id, g.genre_name)"
          class="px-4 py-2 rounded-full bg-[#90CB38]/10 border border-[#90CB38]/40 cursor-pointer"
        >
          <p class="text-lg font-bold text-[#90CB38]">
            {{ g.genre_name }}
          </p>
          <p class="text-white/70 text-xs text-center">
            {{ g.percent.toFixed(1) }}%
          </p>
        </div>
      </div>

      <!-- <p class="text-xs text-white/50 mt-2">
        คุณชอบแนวนี้มากกว่าผู้ใช้ทั่วไป
        <span class="text-[#90CB38] font-bold"> {{ comparePercent }}% </span>
      </p> -->
    </div>

    <p
      v-if="topMood"
      class="text-[#90CB38] font-semibold text-md text-center mt-2"
    >
      คุณคือ {{ topMood }}
    </p>

    <div v-if="tasteRanking.length" class="mt-8">
      <h3 class="text-white/80 text-sm text-center mb-4">
        รสนิยมการดูหนังของคุณ (เรียงตามความชอบจากหนังที่คุณกด ❤️)
      </h3>

      <div class="space-y-3">
        <div
          v-for="(g, i) in tasteRanking"
          :key="g.genre_id"
          class="flex items-center justify-between px-4 py-3 rounded-xl bg-white/5 border border-white/10 transition-all duration-300 hover:bg-white/10"
        >
          <div class="flex items-center gap-3">
            <span class="text-lg font-bold text-[#90CB38]">
              {{ i + 1 }}
            </span>

            <div>
              <p class="text-white font-semibold">
                {{ g.genre_name }}
              </p>
            </div>
          </div>

          <p class="text-[#90CB38] font-bold">{{ g.percent.toFixed(1) }}%</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Chart } from "chart.js/auto";
import { ref, onMounted, watchEffect, computed, watch, nextTick } from "vue";
import { useRouter } from "vue-router";
import dayjs from "dayjs";
import "dayjs/locale/th";
const router = useRouter();

const selectedMonth = ref(dayjs().format("YYYY-MM"));
dayjs.locale("th");

type TasteScore = {
  genre_id: number;
  genre_name: string;
  score: number;
  avg_score?: number;
};

const moodMap: Record<string, string> = {
  Action: "สายเดือด 🔥",
  Adventure: "สายผจญภัย 🧭",
  Animation: "สายการ์ตูน 🎨",
  Comedy: "สายฮา 😂",
  Crime: "สายอาชญากรรม 🕵️‍♂️",
  Documentary: "สายสารคดี 📽️",
  Drama: "สายอิน 😭",
  Family: "สายอบอุ่น 👨‍👩‍👧‍👦",
  Fantasy: "สายแฟนตาซี 🧙‍♂️",
  History: "สายประวัติศาสตร์ 🏺",
  Horror: "สายหลอน 👻",
  Music: "สายดนตรี 🎵",
  Mystery: "สายลึกลับ 🧩",
  Romance: "สายหวาน 💖",
  Science_Fiction: "สายไซไฟ 🚀",
  TV_Movie: "สายหนังทีวี 📺",
  Thriller: "สายลุ้นระทึก 😱",
  War: "สายสงคราม 💣",
  Western: "สายคาวบอย 🤠",
};

const topMood = computed(() => {
  if (!topGenres.value.length) return null;

  const genreName = topGenres.value[0].genre_name;
  return moodMap[genreName] || "สายดูหนังหลากหลาย 🎬";
});

const otherTopGenres = computed(() => {
  if (!data.value?.length) return [];

  return [...data.value]
    .sort((a, b) => b.score - a.score)
    .slice(1, 3)
    .map((g) => ({
      ...g,
      percent: (g.score / totalScore.value) * 100,
    }));
});

const comparePercent = computed(() => {
  if (!topGenres.value.length) return 0;
  const g = topGenres.value[0];
  if (!g.avg_score) return 0;
  return (((g.score - g.avg_score) / g.avg_score) * 100).toFixed(0);
});

const goToCategory = (genre: { genre_id: number; genre_name: string }) => {
  router.push({
    path: "/catagory",
    query: {},
  });
};

const canvasRef = ref<HTMLCanvasElement | null>(null);
let chart: Chart | null = null;

const { data, pending, refresh } = await useFetch<TasteScore[]>(
  () => `/api/user/taste/score?month=${selectedMonth.value}`,
  {
    credentials: "include",
    immediate: true,
  },
);

defineExpose({
  refreshTaste: refresh,
});

const topGenres = computed(() => {
  if (!data.value?.length) return [];

  const maxScore = Math.max(...data.value.map((g) => g.score));

  return data.value
    .filter((g) => g.score === maxScore)
    .map((g) => ({
      ...g,
      percent: (g.score / totalScore.value) * 100,
    }));
});

const totalScore = computed(
  () => data.value?.reduce((sum, g) => sum + g.score, 0) || 0,
);

onMounted(() => {
  watch(
    () => data.value,
    async (val) => {
      if (!val || !val.length) return;

      await nextTick();

      if (!canvasRef.value) {
        console.log("canvas still null");
        return;
      }

      console.log("canvas OK", canvasRef.value);

      if (chart) {
        chart.destroy();
        chart = null;
      }

      chart = new Chart(canvasRef.value, {
        type: "pie",
        data: {
          labels: val.map((v) => v.genre_name),
          datasets: [
            {
              data: val.map((v) => v.score),
              backgroundColor: [
                "#90CB38",
                "#4ADE80",
                "#22C55E",
                "#16A34A",
                "#15803D",
                "#166534",
                "#60A5FA",
                "#38BDF8",
                "#818CF8",
                "#A78BFA",
                "#F472B6",
                "#FB7185",
              ],
              borderWidth: 2,
              borderColor: "#0B0A0A",
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: "right",
              labels: {
                color: "#E5E7EB",
                usePointStyle: true,
              },
            },
          },
        },
      });
    },
    { immediate: true },
  );
});
console.log("canvas:", canvasRef.value);

const tasteRanking = computed(() => {
  if (!data.value?.length) return [];

  return [...data.value]
    .map((g) => ({
      ...g,
      percent: (g.score / totalScore.value) * 100,
      mood: moodMap[g.genre_name] || "สายดูหนัง 🎬",
    }))
    .sort((a, b) => b.percent - a.percent)
    .slice(0, 5);
});

const availableMonths = computed(() => {
  const now = dayjs();
  const months: { value: string; label: string }[] = [];

  for (let i = 0; i < 6; i++) {
    const d = now.subtract(i, "month");

    months.push({
      value: d.format("YYYY-MM"), // เอาไว้ส่ง API
      label: d.format("MMMM YYYY"), // ภาษาไทย
    });
  }

  return months;
});

const trend = computed(() => {
  if (!tasteRanking.value.length) return null;
  return `เดือนนี้คุณอิน ${tasteRanking.value[0].genre_name} เป็นพิเศษ`;
});

watch(selectedMonth, async () => {
  await refresh();
});

const isClientReady = ref(false);

onMounted(() => {
  isClientReady.value = true;
});

watch(data, () => {
  console.log("selectedMonth:", selectedMonth.value);
  console.log("data:", data.value);
});


</script>
