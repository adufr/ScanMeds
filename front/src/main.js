import Vue from 'vue'
import Axios from 'axios'
import App from './App.vue'
import router from './router'
import store from './store'

Vue.config.productionTip = false
Vue.prototype.$http = Axios;

const token = localStorage.getItem('token')
if (token) {
  Vue.prototype.$http.defaults.headers.common['Authorization'] = `Bearer ${token}`
}

// Vue.use(VueResource)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
