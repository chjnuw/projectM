import { ref } from "vue";

export const useUserTags = () => {
  const userTags = useState<any[]>("global-user-tags", () => []);
  const tagChangeMessage = useState<string>("tag-change-msg", () => "");

  return { userTags, tagChangeMessage };
};
