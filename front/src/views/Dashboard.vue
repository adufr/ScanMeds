<template>
  <div class="test">



    <div id="wrapper">

        <sidebar></sidebar>
    
        <div id="content-wrapper" class="d-flex flex-column">
    
          <navbar></navbar>

          <!-- Main Content -->
          <div id="content">
    
            <!-- End of Topbar -->
    
            <div class="container-fluid">
            <!-- TODO: CONTENT -->
            </div>
    
          </div>
          <!-- End of Main Content -->
    
          <footer></footer>

        </div>
    
      </div>

  </div>
</template>

<script>
import Sidebar from '../components/Sidebar.vue'
import Navbar from '../components/Navbar.vue'
import Footer from '../components/Footer.vue'

export default {
  name: 'test',
  components: {
    'sidebar': Sidebar,
    'navbar': Navbar,
    'footer': Footer
  }
}
</script>