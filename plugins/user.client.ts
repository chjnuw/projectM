export default defineNuxtPlugin(async () => {
  const user = useUser();
  try {
    user.value = await $fetch("/api/me", {
      credentials: "include",
    });
  } catch {}
});