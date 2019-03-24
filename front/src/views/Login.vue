<template>
  <div class="container">
    <div class="row">

      <div class="col">
        <div class="form-group">
          <label for="">Email</label>
          <input type="text" id="input-email" class="form-control" placeholder="Adresse mail">
          <br>
          <label for="">Mot de passe</label>
          <input type="password" id="input-password" class="form-control" placeholder="Mot de passe">
        </div>
      </div>

      <div class="col second">
        <img src="@/assets/office-woman.png" alt="Femme travaillant sur un ordinateur" class="img">
      </div>

    </div>
  </div>
</template>

<script>
export default {
  name: 'login'
}
</script>

<style scoped>
.img {
  width: 500px;
  height: 450px;
}

.second {
  background-color: #EAEEFA;
}
</style>
