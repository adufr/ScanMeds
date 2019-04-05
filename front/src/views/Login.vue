<template>
  <div class="container">
    <div class="row">
      <div class="split left">
        <div class="centered">
          <div class="col">
            <img
              src="@/assets/doctor.jpg"
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
        switch (err.response.status) {
          case 401:
          case 404: 
            this.errors.push("Nom d'utilisateur ou mot de passe incorrect")
            break
          default: 
            this.errors.push("Oups... Une erreur est survenue")
            break
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
  background-color: #C6E2ED
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
  background-image: linear-gradient(to right top, #639bc0, #558eb2, #4781a5, #397497, #2a688a);
  border: none;
}
</style>
