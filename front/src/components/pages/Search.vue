<template>
  <div class="container">
    <h1>Rechercher un médicament</h1>

    <div class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
      <div class="input-group">
        <input
          v-model.trim="search"
          type="text"
          class="form-control search-input border-0"
          placeholder="Rechercher un médicament..."
          autofocus
        >
        <div class="input-group-append">
          <button
            class="btn btn-primary search-button"
            type="button"
          >
            <i class="fas fa-search fa-sm" />
          </button>
        </div>
      </div>
    </div>

    <div
      v-show="search"
      id="table"
      class="card shadow mb-4"
    >
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary text-left">
          Résultats
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
              v-for="(medicament, index) in results"
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
                    v-if="favorites.find(favorite => favorite.codeCIS === medicament.codeCIS)"
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
      v-if="!search || (search && !results.length)"
      class="description"
    >
      {{ status }}
    </p>

    <br>

    <Med 
      v-if="isModalVisible"
      :med="med"
      :favorites="favorites"
    />
  </div>
</template>

<script>
import Med from '../Med.vue'

export default {
  name: 'Search',
  components: {
    Med
  },
  data () {
    return {
      search: null,
      results: [],
      status: 'Commencez à taper pour lancer la recherche',
      med: { name: 'test' },
      isModalVisible: false
    }
  },
  watch: {
    search (before, after) {
      this.fetch()
    }
  },
  computed: {
    favorites: function () {
      return this.$attrs.favorites
    }
  },
  methods: {
    fetch: function () {
      this.$http.get(`${this.$proxyUrl}/api/v1/medicaments?query=${encodeURIComponent(this.search)}`).then(res => {
        this.results = res.data  
        this.results.length ? this.status = '' : this.status = 'Aucun résultat à afficher'
      }).catch(err => {
        this.status = 'Une erreur est survenue'
      })
    },
    getDetailOf: function (medId) {
      this.$http.get(`${this.$proxyUrl}/api/v1/medicaments/${medId}`).then(res => {
        this.med = res.data
        this.isModalVisible = true
      })
    },
    capitalizeFirstLetter: function (string) {
      if (!string) return 'Aucune'
      string = string.trim().toLowerCase()
      return string.charAt(0).toUpperCase() + string.slice(1)
    }
  }
}
</script>

<style scoped>
h1 {
  margin: 40px;
}

#table {
  margin: 60px
}

.description {
  margin-top: 50px;
  margin-bottom: 50px;
  font-size: 20px;
  color: rgb(126, 126, 126);
}

.text-primary {
  font-size: 18px;
}

.search-input {
  height: 50px;
  padding: 30px;
  border-radius: 15px
}

.search-button {
  width: 50px;
  border-top-right-radius: 15px;
  border-bottom-right-radius: 15px
}
</style>
