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

      <div class="split right roboto">
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
          
          <!-- ============================= -->
          <!-- == LOGIN FORM =============== -->
          <!-- ============================= -->
          <form
            v-if="form === 'login'"
            class="form-group"
            @submit.prevent="login"
          >
            <h1 class="title">Connexion</h1>

            <hr>

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
              <i class="fas fa-sign-in-alt fa-spacer"></i>
              Se connecter
            </button>

            <hr>

            <div class="text-center">
              <span class="small link">Mot de passe oublié ?</span>
              <span @click="form = 'register'" class="small link">Créer un compte !</span>
            </div>
          </form>


          <!-- ============================= -->
          <!-- == REGISTER FORM ============ -->
          <!-- ============================= -->
          <form
            v-if="form === 'register'"
            class="form-group"
            @submit.prevent="register"
          >
            <h1 class="title">Inscription</h1>

            <hr>

            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span
                  class="input-group-text form-input"
                  style="height: 30px"
                ><i class="fas fa-user"></i></span>
              </div>
              <input
                v-model="firstname"
                :class="{ 'is-invalid': !isValidFirstname, 'is-valid': isValidFirstname }"
                type="text"
                required="true"
                class="form-control form-input"
                placeholder="Prénom"
              >
            </div>

            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span
                  class="input-group-text form-input"
                  style="height: 30px"
                ><i class="fas fa-user" /></span>
              </div>
              <input
                v-model="lastname"
                :class="{ 'is-invalid': !isValidLastname, 'is-valid': isValidLastname }"
                type="text"
                required="true"
                class="form-control form-input"
                placeholder="Nom"
              >
            </div>

            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span
                  class="input-group-text form-input"
                  style="height: 30px"
                ><i class="fas fa-envelope" /></span>
              </div>
              <input
                v-model="email"
                :class="{ 'is-invalid': !isValidEmail, 'is-valid': isValidEmail }"
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
                :class="{ 'is-invalid': !isValidPassword, 'is-valid': isValidPassword }"
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
              <i class="fas fa-user-plus fa-spacer"></i>
              S'inscrire
            </button>

            <hr>

            <div class="text-center">
              <span @click="form = 'login'" class="small link">Vous avez déjà un compte ?</span>
            </div>
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
      firstname: null,
      lastname: null,
      email: null,
      password: null,
      form: 'login'
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

      if (!this.isValidEmail) {
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
  },
  computed: {
    isValidFirstname: function () {
      return this.firstname && this.firstname.length > 2 
    },
    isValidLastname: function () {
      return this.lastname && this.lastname.length > 2 
    },
    isValidEmail: function () {
      const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      return re.test(String(this.email).toLowerCase())
    },
    isValidPassword: function () {
      return this.password && this.password.length > 6
    }
  }
}
</script>

<style scoped>
.roboto {
  font-family: 'Roboto', sans-serif !important;
}

.fa-spacer {
  padding-right: 10px
}

.title {
  /* color: #639BC0; */
  font-size: 40px;
  font-weight:bold;
}

hr {
  margin: 30px
}

.link {
  color: rgb(24, 140, 185);
  display: block;
  text-decoration: none;
  position: relative;
  text-transform: uppercase;
  text-decoration: none;
  
  display: inline-block;
  padding: 5px 10px;
  position: relative;
}

.link::after{
  background: none repeat scroll 0 0 transparent;
  bottom: 0;
  content: "";
  display: block;
  height: 2px;
  left: 50%;
  position: absolute;
  background: #c6e2ed;
  color: rgb(24, 140, 185);
  transition: width 0.3s ease 0s, left 0.3s ease 0s;
  width: 0;
}

.link:hover::after{
  left: 0; 
  width: 100%; 
  cursor: pointer;
}

/* Divise l'écran en deux */
.split {
  height: 100%;
  width: 50%;
  position: fixed;
  z-index: 1;
  top: 0;
  overflow-x: hidden;
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
  top: 50%;
  left: 50%;
  position: absolute;
  text-align: center;
  transform: translate(-50%, -50%);
}

img {
  width: 100%;
  height: 100%;
}

.form-input {
  padding: 30px;
  color: #3a3a3a;
  border: 1px solid #f0f0f0;
}

.btn-login {
  border: none;
  height: 50px;
  width: 175px;
  transition: 0.4s;
  background-color: #558eb2;
}

.btn-login:hover {
  background-color: #326f95;
}
</style>
