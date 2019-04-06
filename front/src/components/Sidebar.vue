<template>
  <ul
    id="accordionSidebar"
    class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
  >
    <!-- Sidebar - Brand -->
    <a
      class="sidebar-brand d-flex align-items-center justify-content-center"
      href="/"
    >
      <div class="sidebar-brand-icon rotate-n-15">
        <i class="fas fa-laugh-wink" />
      </div>
      <div class="sidebar-brand-text mx-3">ScanMeds</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <li class="nav-item">
      <a
        class="nav-link"
        href="/dashboard"
      >
        <i class="fas fa-fw fa-tachometer-alt" />
        <span>Tableau de bord</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
      <button
        @click="toggleSidebar"
        id="sidebarToggle"
        class="rounded-circle border-0"
      />
    </div>
  </ul>
</template>

<script>
export default {
  name: 'Sidebar',
  props: {
    msg: {
      type: String,
      default: ''
    }
  },
  methods: {
    toggleSidebar: function () {
      document.querySelector('body').classList.toggle('sidebar-toggled')
      document.querySelector('.sidebar').classList.toggle('toggled')
    }
  }
}
</script>

<style scoped>
</style>
