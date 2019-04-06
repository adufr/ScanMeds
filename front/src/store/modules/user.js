const state = {
  isLogged: !!localStorage.getItem('token')
}

const getters = {
  isLogged: state => {
    return state.isLogged
  }
}

const mutations = {
    auth_request(state){
      state.status = 'loading'
      localStorage.setItem('status', 'loading')
    },
    auth_success(state, token, user){
      state.status = 'success'
      localStorage.setItem('status', 'success')
      state.token = token
      console.log(token)
      localStorage.setItem('token', token)
      state.user = user
      console.log(user)
      localStorage.setItem('user', user)
    },
    auth_error(state){
      state.status = 'error'
      localStorage.setItem('status', 'error')
      localStorage.removeItem('token')
    },
    logout(state){
      state.status = ''
      localStorage.removeItem('status')
      state.token = ''
      localStorage.removeItem('token')
      state.user = ''
      localStorage.removeItem('user')
    },
}

const actions = {
  login: ({commit}, object) => {
    commit('login', object)
  },
  logout: ({commit}) => {
    commit('logout')
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
