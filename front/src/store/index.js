import Vue from 'vue'
import Vuex from 'vuex'
// import axios from 'axios'

import user from './modules/user'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    user
  }
})

// export default new Vuex.Store({
//   state: {
//     user : localStorage.getItem('user') || '',
//     token: '',
//     status: localStorage.getItem('status') || ''
//   },
//   mutations: {
//     auth_request(state){
//       state.status = 'loading'
//       localStorage.setItem('status', 'loading')
//     },
//     auth_success(state, token, user){
//       state.status = 'success'
//       localStorage.setItem('status', 'success')
//       state.token = token
//       console.log(token)
//       localStorage.setItem('token', token)
//       state.user = user
//       console.log(user)
//       localStorage.setItem('user', user)
//     },
//     auth_error(state){
//       state.status = 'error'
//       localStorage.setItem('status', 'error')
//       localStorage.removeItem('token')
//     },
//     logout(state){
//       state.status = ''
//       localStorage.removeItem('status')
//       state.token = ''
//       localStorage.removeItem('token')
//       state.user = ''
//       localStorage.removeItem('user')
//     },
//   },
//   actions: {
//     login({commit}, data){
//       return new Promise((resolve, reject) => {
//         commit('auth_request')
//         axios.post('http://localhost:3000/api/v1/auth', data)
//         .then(res => {
//           const token = res.data.accessToken
//           const user = res.data.user
//           axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
//           commit('auth_success', { token, user })
//           resolve(res)
//         })
//         .catch(err => {
//           commit('auth_error')
//           reject(err)
//         })
//       })
//     },
//     logout({commit}){
//       return new Promise((resolve, reject) => {
//         commit('logout')
//         delete axios.defaults.headers.common['Authorization']
//         resolve()
//       })
//     }
//   },
//   getters : {
//     isLoggedIn: state => !!state.token,
//     authStatus: state => state.status,
//     user: state => state.user
//   }
// })
