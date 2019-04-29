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
        <h6 class="m-0 font-weight-bold text-primary left">
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
            <!-- <span> -->
            <thead>
              <tr>
                <th class="left">
                  Médicament
                </th>
                <th class="left">
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
                @click="getDetailOf(medicament.codeCIS)"
                data-toggle="modal"
                data-target=".med-modal"
              >
                <td class="left">
                  {{ medicament.denomination }}
                </td>
                <td class="left">
                  {{ capitalizeFirstLetter(medicament.denomination.split(',')[1]) }}
                </td>
                <td>{{ medicament.codeCIS }}</td>
              </tr>
            </tbody>
            <!-- </span> -->
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
      @click="isModalVisible = false"
      :med="med"
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
      med: {name: 'test'},
      isModalVisible: false
    }
  },
  watch: {
    search (before, after) {
      this.fetch()
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
      console.log(medId)
      this.isModalVisible = true
      this.$http.get(`${this.$proxyUrl}/medicaments/${medId}`).then(res => {
        this.med = res.data
      })
    },
    capitalizeFirstLetter: function (string) {
      string = string.trim().toLowerCase()
      return string.charAt(0).toUpperCase() + string.slice(1);
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

.left {
  text-align: left;
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
