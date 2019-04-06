import Vue from 'vue'
import Axios from 'axios'
import App from './App.vue'
import router from './router'
// import store from './store/index'

Vue.config.productionTip = false

// replace default http module with axios
Vue.prototype.$http = Axios;

new Vue({
  router,
  // store,
  render: h => h(App)
}).$mount('#app')
