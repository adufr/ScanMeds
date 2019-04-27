import Vue from 'vue'
import Axios from 'axios'
import App from './App.vue'
import router from './router'
// import store from './store/index'

Vue.config.productionTip = false

const token = localStorage.getItem('token')
Axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
Axios.defaults.headers.common['Target-URL'] = 'https://www.open-medicaments.fr/'

// replace default http module with axios
Vue.prototype.$http = Axios;

// create a global variable
Vue.prototype.$apiUrl = process.env.VUE_APP_API_URL
Vue.prototype.$proxyUrl = process.env.VUE_APP_PROXY_URL

new Vue({
  router,
  // store,
  render: h => h(App)
}).$mount('#app')
