export default defineNuxtPlugin(async () => {
  const user = useUser();

  if (user.value) return; // 🔒 กันยิงซ้ำ

  try {
    const me = await $fetch("/api/me", {
      credentials: "include",
    });

    if (me) {
      user.value = me;
    }
  } catch {
    user.value = null; // ❗ สำคัญ
  }
});
