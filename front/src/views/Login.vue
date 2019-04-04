<template>
  <div class="container">
    <div class="row">
      <div class="split left">
        <div class="centered">
          <div class="col">
            <img
              src="@/assets/office-woman.png"
              alt="Femme travaillant sur un ordinateur"
              class="img img-fluid"
            >
          </div>
        </div>
      </div>

      <div class="split right">
        <div class="centered">
          <div
            v-for="(error, index) in errors"
            :key="index"
            class="alert alert-danger alert-dismissible fade show"
            role="alert"
          >
            {{ error }}
            <button
              type="button"
              class="close"
              data-dismiss="alert"
              aria-label="Close"
            >
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          
          <form
            class="form-group"
            @submit.prevent="login"
          >
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span
                  class="input-group-text form-input"
                  style="height: 30px"
                ><i class="fas fa-envelope" /></span>
              </div>
              <input
                v-model="email"
                type="email"
                required="true"
                class="form-control form-input"
                placeholder="Adresse mail"
              >
            </div>

            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span
                  class="input-group-text form-input"
                  style="height: 30px"
                ><i class="fas fa-lock" /></span>
              </div>
              <input
                v-model="password"
                type="password"
                required="true"
                class="form-control form-input"
                placeholder="Mot de passe"
              >
            </div>

            <button
              type="submit"
              class="btn btn-primary btn-login"
            >
              Se connecter
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import router from '../router'

export default {
  data () {
    return {
      errors: [],
      email: null,
      password: null
    }
  },
  mounted () {
    // if user is already connected, send him directly to the dashboard
    if (this.$store.getters.isLoggedIn) {
      router.push('/dashboard')
    }
  },
  methods: {
    login: function () {
      this.errors = []

      if (!this.email) {
        this.errors.push('Veuillez indiquer votre adresse mail')
      }

      if (!this.password) {
        this.errors.push('Veuillez indiquer votre mot de passe')
      }

      const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      if (!re.test(String(this.email).toLowerCase())) {
        this.errors.push("L'adresse mail indiquée est invalide")
      }

      // if there are errors, don't query the api
      if (this.errors.length) return

      // call the login route
      this.$store.dispatch('login', { email: this.email, password: this.password }).then(() => {
        router.push('/dashboard')
      }).catch((err) => {
        // TODO: be able to handle errors
        // console.log(err)
        if (err.status === 401) {
          this.errors.push("Nom d'utilisateur ou mot de passe incorrect")
        } else {
          this.errors.push("Oups... Une erreur est survenue")
        }
      })
    }
  }
}
</script>

<style scoped>
/* Divise l'écran en deux */
.split {
  height: 100%;
  width: 50%;
  position: fixed;
  z-index: 1;
  top: 0;
  overflow-x: hidden;
  padding-top: 20px;
}

.left {
  left: 0;
  background-color: rgb(219, 255, 185);
}

.right {
  right: 0;
  background-color: #ffffff;
}

/* Centrage vertical & horizontal */
.centered {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
}

img {
  width: 100%;
  height: 100%;
}

.form-input {
  padding: 30px;
  border: 1px solid #f0f0f0;
  color: #3a3a3a;
}

.btn-login {
  height: 50px;
  width: 150px;
/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#88e56b+0,61c419+100,64e000+100 */
background: #88e56b; /* Old browsers */
background: -moz-linear-gradient(left, #88e56b 0%, #61c419 100%, #64e000 100%); /* FF3.6-15 */
background: -webkit-linear-gradient(left, #88e56b 0%,#61c419 100%,#64e000 100%); /* Chrome10-25,Safari5.1-6 */
background: linear-gradient(to right, #88e56b 0%,#61c419 100%,#64e000 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#88e56b', endColorstr='#64e000',GradientType=1 ); /* IE6-9 */
border: none;
}
</style>
