<template>
<ClientOnly>
  <Navbar />
  <main
    class="overflow-auto bg-black text-white min-h-screen pb-10" >
    <slot />
  </main>

  <Footer />
</ClientOnly>
</template>
<script setup>


</script>
