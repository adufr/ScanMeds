<template class="roboto" />

<script>
import { mapState } from 'vuex'
import router from '../router'

export default {
  name: 'Navbar',
  props: {
    msg: {
      type: String,
      default: ''
    }
  },
  computed: {
    user: () => {
      return JSON.parse(localStorage.getItem('user'))
    }
  },
  mounted () {
    if (!localStorage.getItem('token')) {
      router.push('/')
    }
  },
  methods: {
    logout: function () {
      localStorage.removeItem('token')
      localStorage.removeItem('user')
      router.push('/')
    },
    toggleSidebar: function () {
      document.querySelector('body').classList.toggle('sidebar-toggled')
      document.querySelector('.sidebar').classList.toggle('toggled')
    }
  }
}
</script>

<style scoped>
.roboto {
  font-family: 'Roboto', sans-serif !important;
}
</style>
