<template>
  <div class="flex items-center gap-2 w-full">
    <button
      class="px-3 py-1 bg-gray-700 text-white rounded hover:bg-gray-600 "
      @click="sortAZ"
    >
      A → Z
    </button>
    <button
      class="px-3 py-1 bg-gray-700 text-white rounded hover:bg-gray-600"
      @click="sortZA"
    >
      Z → A
    </button>
  </div>
</template>

<script setup lang="ts">
import { defineProps, defineEmits, unref, Ref } from "vue";

const props = defineProps<{
  items: any[] | Ref<any[]>; // array ของ object ที่จะ sort
  keyName: string; // property ของ object เช่น 'name' หรือ 'title'
}>();

const emit = defineEmits<{
  (e: "update", sorted: any[]): void;
}>();

// Options สำหรับ localeCompare
const localeOptions: Intl.CollatorOptions = {
  sensitivity: "base", // ไม่สน case และ accent เล็กๆ
  numeric: true,       // ให้เลขเรียงถูกต้อง เช่น "Movie 2" < "Movie 10"
};

const locales = ["th", "en"]; // ไทยก่อน อังกฤษ

const sortAZ = () => {
  const itemsArray = Array.isArray(unref(props.items)) ? unref(props.items) : [];
  const sorted = [...itemsArray].sort((a, b) =>
    String(a[props.keyName]).localeCompare(String(b[props.keyName]), locales, localeOptions)
  );
  emit("update", sorted);
};

const sortZA = () => {
  const itemsArray = Array.isArray(unref(props.items)) ? unref(props.items) : [];
  const sorted = [...itemsArray].sort((a, b) =>
    String(b[props.keyName]).localeCompare(String(a[props.keyName]), locales, localeOptions)
  );
  emit("update", sorted);
};
</script>
