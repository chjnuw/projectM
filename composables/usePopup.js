import { reactive } from "vue";

// singleton shared state
const state = reactive({
  isOpen: false,
  payload: null,
});

export function usePopup() {
  function open(payload = null) {
    state.payload = payload;
    state.isOpen = true;
  }
  function close() {
    state.isOpen = false;
    state.payload = null;
  }
  return { state, open, close };
}
    