import { library } from '@fortawesome/fontawesome-svg-core'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

// เลือก icon ที่จะใช้ (เพิ่มได้)
import { faUser, faHome, faTrash, faEdit, faMagnifyingGlass, faPlay } from '@fortawesome/free-solid-svg-icons'
import { faHeart, faCircleUser, } from '@fortawesome/free-regular-svg-icons'
import { faFacebook, faGithub } from '@fortawesome/free-brands-svg-icons'

// เพิ่มไอคอนเข้าคลัง
library.add(faUser, faHome, faTrash, faEdit, faHeart, faFacebook, faGithub, faMagnifyingGlass, faCircleUser, faPlay)
export default defineNuxtPlugin((nuxtApp) => {
  nuxtApp.vueApp.component('font-awesome-icon', FontAwesomeIcon)
})
