<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script>
import router from './router'

export default {
  created: function () {
    // intercept all incoming http requests, and check if user is still logged in
    this.$http.interceptors.response.use(undefined, (err) => {
      return new Promise(function (resolve, reject) {
        if (err.status === 401 && err.config && !err.config.__isRetryRequest) {
          localStorage.removeItem('token')
          localStorage.removeItem('user')
          router.push('/')
        }
        throw err
      })
    })
  }
}
</script>


<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
