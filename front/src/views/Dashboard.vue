<template>
  <div class="test">
    <div id="wrapper">
      <Sidebar />

      <div
        id="content-wrapper"
        class="d-flex flex-column"
      >
        <Navbar />

        <div id="content">
          <div class="container-fluid">
            <!-- TODO: CONTENT -->
          </div>
        </div>

        <Footer />
      </div>
    </div>
  </div>
</template>

<script>
import Sidebar from '../components/Sidebar.vue'
import Navbar from '../components/Navbar.vue'
import Footer from '../components/Footer.vue'

export default {
  name: 'Dashboard',
  components: {
    Sidebar,
    Navbar,
    Footer
  }
}
</script>
