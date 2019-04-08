<template class="roboto">
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

    <hr class="sidebar-divider my-0">

    <li class="nav-item">
      <a
        class="nav-link"
        href="/dashboard"
      >
        <i class="fas fa-fw fa-tachometer-alt" />
        <span class="here">Tableau de bord</span></a>
    </li>

    <hr class="sidebar-divider">

    <div class="sidebar-heading">
      Médicaments
    </div>

    <li class="nav-item">
      <a
        class="nav-link"
        href="charts.html"
      >
        <i class="fas fa-fw fa-search" />
        <span>Rechercher</span></a>
    </li>

    <li class="nav-item">
      <a class="nav-link">
        <i class="fas fa-fw fa-heart" />
        <span>Médicaments favoris</span></a>
    </li>

    <li class="nav-item">
      <a
        class="nav-link"
        href="charts.html"
      >
        <i class="fas fa-fw fa-table" />
        <span>Recherches récentes</span></a>
    </li>

    <hr class="sidebar-divider">

    <div class="sidebar-heading">
      Mon espace santé
    </div>

    <li class="nav-item">
      <a
        class="nav-link"
        href="charts.html"
      >
        <i class="fas fa-fw fa-user" />
        <span>Informations</span></a>
    </li>

    <li class="nav-item">
      <a
        class="nav-link"
        href="charts.html"
      >
        <i class="fas fa-fw fa-address-book" />
        <span>Rendez-vous</span></a>
    </li>

    <hr class="sidebar-divider">

    <div class="sidebar-heading">
      Autres
    </div>

    <li class="nav-item">
      <a
        class="nav-link"
        href="charts.html"
      >
        <i class="fas fa-fw fa-cogs" />
        <span>Paramètres</span></a>
    </li>

    <hr class="sidebar-divider">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
      <button
        id="sidebarToggle"
        class="rounded-circle border-0"
        @click="toggleSidebar"
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
.roboto {
  font-family: 'Roboto', sans-serif !important;
}

</style>
