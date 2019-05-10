<template>
  <div class="container-fluid">
    <!-- Page heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 class="h3 mb-0 text-gray-800">
        Tableau de bord
      </h1>
    </div>

    <div class="row">
      <!-- Profile completed info -->
      <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-info shadow h-100 py-2">
          <div class="card-body">
            <div class="row no-gutters align-items-center">
              <div class="col mr-2 text-left">
                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                  Profil rempli à
                </div>
                <div class="row no-gutters align-items-center">
                  <div class="col-auto">
                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
                      30%
                    </div>
                  </div>
                  <div class="col">
                    <div class="progress progress-sm mr-2">
                      <div
                        class="progress-bar bg-info"
                        role="progressbar"
                        style="width: 30%"
                        aria-valuenow="30"
                        aria-valuemin="0"
                        aria-valuemax="100"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-auto">
                <i class="fas fa-clipboard-list fa-2x text-gray-300" />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Notifications counter -->
      <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-warning shadow h-100 py-2">
          <div class="card-body">
            <div class="row no-gutters align-items-center">
              <div class="col mr-2 text-left">
                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                  Notifications non lues
                </div>
                <div class="h5 mb-0 font-weight-bold text-gray-800">
                  {{ notifications.length >= 1 ? notifications.length : 'Aucune' }}
                </div>
              </div>
              <div class="col-auto">
                <i class="fas fa-bell fa-2x text-gray-300" />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Favs medicines -->
      <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-primary shadow h-100 py-2">
          <div class="card-body">
            <div class="row no-gutters align-items-center">
              <div class="col mr-2 text-left">
                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                  Médicaments favoris
                </div>
                <div class="h5 mb-0 font-weight-bold text-gray-800">
                  {{ favorites.length >= 1 ? favorites.length : 'Aucun' }}
                </div>
              </div>
              <div class="col-auto">
                <i class="fas fa-star fa-2x text-gray-300" />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Next appointment -->
      <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-success shadow h-100 py-2">
          <div class="card-body">
            <div class="row no-gutters align-items-center">
              <div class="col mr-2 text-left">
                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                  Prochain rendez-vous
                </div>
                <div class="h5 mb-0 font-weight-bold text-gray-800">
                  (à venir...)
                </div>
              </div>
              <div class="col-auto">
                <i class="fas fa-calendar-alt fa-2x text-gray-300" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Content Row -->
    <div class="row">
      <!-- website -->
      <div class="col-lg-6 mb-4">
        <div class="card shadow mb-4">
          <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">
              Portail en ligne
            </h6>
          </div>
          <div class="card-body">
            <div class="text-center">
              <img
                class="img-fluid px-3 px-sm-4 mt-3 mb-4"
                style="width: 25rem;"
                src="../../assets/doctors.svg"
                alt="Médecins"
              >
            </div>
            <p>
              Votre dossier médical en ligne !
            </p>
            <a
              rel="nofollow"
              href="/"
            >
              Accéder au site →
            </a>
          </div>
        </div>
      </div>
      <!-- mobile app -->
      <div class="col-lg-6 mb-4">
        <div class="card shadow mb-4">
          <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">
              Application mobile
            </h6>
          </div>
          <div class="card-body">
            <div class="text-center">
              <img
                class="img-fluid px-3 px-sm-4 mt-3 mb-4"
                style="width: 25rem;"
                src="../../assets/mobile_application.svg"
                alt="Application mobile"
              >
            </div>
            <p>
              Téléchargez notre application mobile !
            </p>
            <a
              target="_blank"
              rel="nofollow"
              href=""
            >
              En savoir plus →
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Main',
  data () {
    return {
    }
  },
  computed: {
    notifications: function () {
      return this.$attrs.notifications
    },
    favorites: function () {
      return this.$attrs.favorites
    }
  }
}
</script>

<style scoped>
.img-fluid {
  max-height: 260px
}
</style>
