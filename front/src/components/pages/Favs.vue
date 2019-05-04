<template>
  <div class="container">
    <h1 class="mt-5">
      Médicaments favoris
    </h1>

    <div
      v-show="favorites.length"
      id="table"
      class="card shadow mt-5 mb-5"
    >
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary text-left">
          Médicaments favoris
        </h6>
      </div>
      <div class="card-body">
        <div class="table-responsive">
          <table
            class="table table-bordered"
            width="100%"
            cellspacing="0"
          >
            <thead>
              <tr>
                <th class="text-left">
                  Médicament
                </th>
                <th class="text-left">
                  Type
                </th>
                <th>(CIS)</th>
              </tr>
            </thead>
            <tbody
              v-for="(medicament, index) in favorites"
              :key="index"
            >
              <tr
                data-toggle="modal"
                data-target=".med-modal"
                @click="getDetailOf(medicament.codeCIS)"
              >
                <td class="text-left">
                  {{ medicament.denomination.split(',')[0] }}
                  <i
                    v-if="favorites.find(id => id === medicament.codeCIS)"
                    class="fas fa-star ml-2"
                    style="color: #F4B619"
                  />
                </td>
                <td class="text-left">
                  {{ medicament && medicament.denomination.length >= 2 ? capitalizeFirstLetter(medicament.denomination.split(',')[1]) : 'Aucune' }}
                </td>
                <td>{{ medicament.codeCIS }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <p
      v-if="!favorites.length"
      class="description"
    >
      Vous n'avez aucun médicament favoris
    </p>

    <Med 
      :med="med"
      :favorites="favorites"
    />
  </div>
</template>

<script>
import Med from '../Med.vue'

export default {
  name: 'Favs',
  components: {
    Med
  },
  data () {
    return {
      status: '',
      med: { name: 'test' },
      isModalVisible: false
    }
  },
  computed: {
    favorites: function () {
      return this.$attrs.favorites
    }
  },
  methods: {
    capitalizeFirstLetter: function (string) {
      if (!string) return 'Aucune'
      string = string.trim().toLowerCase()
      return string.charAt(0).toUpperCase() + string.slice(1)
    },
    getDetailOf: function (medId) {
      this.$http.get(`${this.$proxyUrl}/api/v1/medicaments/${medId}`).then(res => {
        this.med = res.data
        this.isModalVisible = true
      })
    }
  }
}
</script>

<style scoped>
.description {
  margin-top: 50px;
  margin-bottom: 50px;
  font-size: 20px;
  color: rgb(126, 126, 126);
}
</style>
