<template>
  <div class="container-fluid">
    <h1 class="mt-3">
      Mon profil
    </h1>    
    <p class="text-gray-500 mb-5">
      Renseignez ici vos informations médicales.<br>
      (Ces dernières ne sont visibles que par vos médecins)
    </p>

    <div class="row text-left">
      <div class="col-lg-6">
        <!-- informations générales -->
        <div class="card shadow mb-4">
          <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">
              Mon compte
            </h6>
          </div>
          <div class="card-body text-gray-600">
            <a
              class="btn btn-warning btn-icon-split"
              disabled
            >
              <span class="icon text-white-50">
                <i class="fas fa-exclamation-triangle" />
              </span>
              <span class="text text-white">
                Si vous modifiez l'une des informations suivantes vous devrez vous reconnecter
              </span>
            </a>
            <form>
              <div class="form-row">
                <!-- username -->
                <div class="form-group col-md-6 mt-3">
                  <label 
                    for="username"
                    class="text-primary"
                  >
                    Nom d'utilisateur
                  </label>
                  <input
                    id="username"
                    v-model="user.username"
                    type="text"
                    class="form-control bg-light border-0 m-auto "
                    placeholder="Nom d'utilisateur"
                    aria-label="Nom d'utilisateur"
                    disabled
                    readonly
                  >
                </div>
                <!-- email -->
                <div class="form-group col-md-6 mt-3">
                  <label 
                    for="email"
                    class="text-primary"
                  >
                    Adresse mail
                  </label>
                  <input
                    id="email"
                    v-model="user.email"
                    type="email"
                    class="form-control bg-light border-0 m-auto "
                    placeholder="Adresse mail"
                    aria-label="Adresse mail"
                    required
                  >
                </div>
              </div>
              <div class="form-row">
                <!-- firstname -->
                <div class="form-group col-md-6 mt-3">
                  <label 
                    for="firstname"
                    class="text-primary"
                  >
                    Prénom
                  </label>
                  <input
                    id="firstname"
                    v-model="user.firstname"
                    type="text"
                    class="form-control bg-light border-0 m-auto "
                    placeholder="Prénom"
                    aria-label="Prénom"
                    required
                  >
                </div>
                <!-- lastname -->
                <div class="form-group col-md-6 mt-3">
                  <label 
                    for="lastname"
                    class="text-primary"
                  >
                    Nom
                  </label>
                  <input
                    id="lastname"
                    v-model="user.lastname"
                    type="text"
                    class="form-control bg-light border-0 m-auto "
                    placeholder="Nom"
                    aria-label="Nom"
                    required
                  >
                </div>
              </div>
              <!-- birthdate -->
              <div class="form-group mt-3">
                <label 
                  for="birthdate"
                  class="text-primary"
                >
                  Date de naissance
                </label>
                <input
                  id="birthdate"
                  type="text"
                  class="form-control bg-light border-0 m-auto "
                  placeholder="Date de naissance"
                  aria-label="Date de naissance"
                  required
                >
              </div>
              <a 
                class="btn btn-success btn-icon-split float-right"
                @click="update1($event)"
              >
                <span class="icon text-white-50">
                  <i class="fas fa-check" />
                </span>
                <span class="text text-white">Sauvegarder</span>
              </a>
            </form>
          </div>
        </div>
      </div>
      <div class="col-lg-6">
        <!-- informations médicales -->
        <div class="card shadow mb-4">
          <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">
              Ma santé
            </h6>
          </div>
          <div class="card-body text-gray-600">
            Indiquez ici vos informations personnelles de santé.
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import router from '../../router'

export default {
  name: 'Profile',
  data () {
    return {
      user: JSON.parse(localStorage.getItem('user'))
    }
  },
  mounted () {
    // get all user's informations according to the current user's id (jwt)
    this.$http.get(`${this.$apiUrl}/user/${this.user._id}`).then(res => {
      this.user = res.data.user  
    })
  },
  methods: {
    update1: function (event) {
      if (event.target.getAttribute('disabled') !== null) return

      event.target.toggleAttribute('disabled')
      this.$http.patch(`${this.$apiUrl}/user/${this.user._id}`, this.user).then(res => {
        event.target.toggleAttribute('disabled')
        // log the user out
        localStorage.removeItem('token')
        localStorage.removeItem('user')
        router.push('/')
      })
    }
  }
}
</script>

<style scoped>
</style>
