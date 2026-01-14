<template>
  <div class="grid grid-cols-5 gap-4 px-4 py-6 animate-pulse">
    <SkeletonCatagorySkeletonCard v-for="i in count" :key="i" />
  </div>
</template>

<script setup lang="ts">
defineProps<{
  count?: number;
}>();
</script>
