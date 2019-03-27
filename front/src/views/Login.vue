<template>
  <div class="container">
    <div class="row">

      <div class="split left">
        <div class="centered">
          <div class="col">
            <img src="@/assets/office-woman.png" alt="Femme travaillant sur un ordinateur" class="img img-fluid">
          </div>
        </div>
      </div>

      <div class="split right">
        <div class="centered">

          <div class="form-group">

            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text form-input" style="height: 30px"><i class="fas fa-envelope"></i></span>
              </div>
              <input type="email" class="form-control form-input" placeholder="Adresse mail" v-model="email">
            </div>

            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <span class="input-group-text form-input" style="height: 30px"><i class="fas fa-lock"></i></span>
              </div>
              <input type="password" class="form-control form-input" placeholder="Mot de passe" v-model="password">
            </div>
            
            <button type="button" class="btn btn-primary btn-login" @click="login()">Se connecter</button>

          </div>

        </div>
      </div>

    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: '',
      password: '' 
    }
  },
  methods: {
    login() {
      console.log('please login')
      this.$http.post('http://localhost:3001/api/v1/auth', { email: this.email, password: this.password })
        .then((response) => {
          this.accessToken = response.body.accessToken  
        }, (error) => {
          console.error(error)
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
/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#a2bf59+0,61c419+100,93e256+100 */
/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#a2bf59+0,61c419+100,64e000+100 */
/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#88e56b+0,61c419+100,64e000+100 */
background: #88e56b; /* Old browsers */
background: -moz-linear-gradient(left, #88e56b 0%, #61c419 100%, #64e000 100%); /* FF3.6-15 */
background: -webkit-linear-gradient(left, #88e56b 0%,#61c419 100%,#64e000 100%); /* Chrome10-25,Safari5.1-6 */
background: linear-gradient(to right, #88e56b 0%,#61c419 100%,#64e000 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#88e56b', endColorstr='#64e000',GradientType=1 ); /* IE6-9 */
border: none;
}
</style>
