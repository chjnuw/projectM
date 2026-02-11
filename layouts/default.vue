<template>
<ClientOnly>
  <Navbar />
  <main
    class="overflow-auto bg-black text-white min-h-screen" >
    <slot />
  </main>

  <Footer />
  <GlobalLoading />
</ClientOnly>
</template>
<script setup lang="ts">
import { onMounted } from "vue";
import { useGenres } from "../composables/useGenres";
import { useUser } from "../composables/useUser"
const { loadGenres } = useGenres();
onMounted(() => {
  loadGenres();
});

const user = useUser();

onMounted(async () => {
  if (!user.value) {
    try {
      user.value = await $fetch("/api/me");
    } catch {
      user.value = null;
    }
  }
});
</script>
