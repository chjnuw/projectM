    <template>
    <div
        class="mt-20 mx-auto max-w-3xl rounded-3xl bg-gradient-to-b from-[#121212] to-[#0B0A0A] border border-white/10 p-8 shadow-xl"
    >
        <div v-if="tasteCompare.length" class="mt-12">
        <h2 class="font-bold text-xl md:text-2xl text-white text-center mb-6">
            เปรียบเทียบรสนิยม <br class="md:hidden" />
            <span class="text-white/60 text-sm font-normal">
            {{ compareMonthLabel }}
            </span>
        </h2>

        <div class="space-y-3">
            <div
            v-for="(g, i) in tasteCompare"
            :key="g.genre_id"
            class="flex items-center justify-between px-4 py-3 rounded-xl bg-white/5 border border-white/10 hover:bg-white/10 transition"
            >
            <!-- ซ้าย -->
            <div class="flex items-center gap-3">
                <span class="text-lg font-bold text-[#90CB38]">
                {{ i + 1 }}
                </span>
                <p class="text-white font-medium">
                {{ genreMap[g.genre_id] }}
                </p>
            </div>

            <!-- ขวา -->
            <div
                class="flex items-center gap-2 text-sm font-semibold"
                :class="{
                'text-green-400': g.diff > 0,
                'text-red-400': g.diff < 0,
                'text-gray-400': g.diff === 0,
                }"
            >
                <span class="text-lg">
                {{ g.diff > 0 ? "⬆️" : g.diff < 0 ? "⬇️" : "➖" }}
                </span>

                <span>
                <template v-if="typeof g.percent === 'number'">
                    <template v-if="Math.abs(g.percent) < 0.1"> ≈ 0% </template>
                    <template v-else>
                    {{ g.percent > 0 ? "+" : "" }}{{ g.percent.toFixed(1) }}%
                    </template>
                </template>
                <template v-else> ใหม่ </template>
                </span>

                <span
                class="px-2 py-0.5 rounded-full text-xs border"
                :class="{
                    'border-green-400/40 bg-green-400/10': g.percent > 0,
                    'border-red-400/40 bg-red-400/10': g.percent < 0,
                    'border-white/20 bg-white/5':
                    g.percent === 0 || g.percent === null,
                }"
                >
                {{
                    g.percent === null
                    ? "เริ่มสนใจ"
                    : g.percent > 0
                        ? "สนใจมากขึ้น"
                        : g.percent < 0
                        ? "สนใจลดลง"
                        : "คงที่"
                }}
                </span>
            </div>
            </div>
        </div>
        </div>
    </div>
    </template>

<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import { useTasteProfile } from "../composables/useTasteProfile";
import { compareTaste } from "../composables/useTasteCompare";
import dayjs from "dayjs";
import "dayjs/locale/th";
dayjs.locale("th");

const tasteCompare = ref<any[]>([]);

type TasteProfileItem = {
  genre_id: number;
  score: number;
};

const tasteProfile = ref<TasteProfileItem[]>([]);

type TasteCompare = {
  genre_id: number;
  current: number;
  previous: number;
  diff: number;
  percent: number | null;
};
const tasteReady = ref(false);

onMounted(async () => {
  const res = await useTasteProfile();

  tasteProfile.value = res.profile;

  tasteCompare.value = compareTaste(res.current, res.previous).map((g) => {
    const percent = g.previous === 0 ? null : (g.diff / g.previous) * 100;

    return {
      ...g,
      percent,
    };
  });

  tasteReady.value = true;
});
const selectedMonth = ref(dayjs().format("YYYY-MM"));

const compareMonthLabel = computed(() => {
  const current = dayjs(selectedMonth.value);
  const previous = current.subtract(1, "month");

  return `${current.format("MMMM YYYY")} vs ${previous.format("MMMM YYYY")}`;
});
</script>

<style></style>
