


<template>
  <div>
    <!-- modal -->
    <div
      class="modal fade med-modal"
      tabindex="-1"
      role="dialog"
    >
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              {{ med.denomination.split(',')[0] }}
            </h5>
            <div>
              <a
                class="btn btn-icon-split"
                :class="isInFavorites ? 'btn-danger' : 'btn-warning'"
                @click="toggleFavorite($event)"
              >
                <span class="icon text-white-50">
                  <i class="fas fa-star" />
                </span>
                <span class="text text-white">{{ isInFavorites ? 'Retirer des favoris' : 'Ajouter au favoris' }}</span>
              </a>
            </div>
          </div>

          <div class="modal-body">
            <div class="row">
              <!-- price card -->
              <div class="col-xl mb-3">
                <div
                  class="card shadow h-100 py-2"
                  :class="medEtatCommercialisation ? 'border-left-success' : 'border-left-warning'"
                >
                  <div class="card-body">
                    <div class="row no-gutters align-items-center">
                      <div class="col mr-2">
                        <div
                          class="text-xs font-weight-bold text-uppercase mb-1"
                          :class="medEtatCommercialisation ? 'text-success' : 'text-warning'"
                        >
                          Prix
                          <div class="h5 mt-3 mb-3 font-weight-bold text-gray-800">
                            {{ medPrice }}
                          </div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-dollar-sign fa-2x text-gray-300" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- "shape" card -->
              <div class="col-xl mb-3">
                <div
                  class="card shadow h-100 py-2"
                  :class="medEtatCommercialisation ? 'border-left-success' : 'border-left-warning'"
                >
                  <div class="card-body">
                    <div class="row no-gutters align-items-center">
                      <div class="col mr-2">
                        <div
                          class="text-xs font-weight-bold text-uppercase mb-1"
                          :class="medEtatCommercialisation ? 'text-success' : 'text-warning'"
                        >
                          Forme
                          <div class="h5 mt-3 mb-3 font-weight-bold text-gray-800">
                            {{ medShape }}
                          </div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-pills fa-2x text-gray-300" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- "administration" card -->
              <div class="col-xl mb-3">
                <div
                  class="card shadow h-100 py-2"
                  :class="medEtatCommercialisation ? 'border-left-success' : 'border-left-warning'"
                >
                  <div class="card-body">
                    <div class="row no-gutters align-items-center">
                      <div class="col mr-2">
                        <div
                          class="text-xs font-weight-bold text-uppercase mb-1"
                          :class="medEtatCommercialisation ? 'text-success' : 'text-warning'"
                        >
                          Voie d'administration
                          <div class="h5 mt-3 mb-3 font-weight-bold text-gray-800">
                            {{ medAdministration }}
                          </div>
                        </div>
                        <div class="col-auto">
                          <i class="fas fa-prescription-bottle-alt fa-2x text-gray-300" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="row">
              <!-- indications thérapeutiques -->
              <div class="card shadow mb-4 ml-3 mr-3 w-100">
                <a
                  href="#indicationsTherapeutiques"
                  class="d-block card-header py-3"
                  data-toggle="collapse"
                  role="button"
                  aria-expanded="true"
                  aria-controls="indicationsTherapeutiques"
                >
                  <h6
                    class="m-0 font-weight-bold"
                    :class="medEtatCommercialisation ? 'text-success' : 'text-warning'"
                  >
                    Indications thérapeutiques
                  </h6>
                </a>

                <div
                  id="indicationsTherapeutiques"
                  class="collapse"
                >
                  <div class="card-body text-left">
                    <!-- eslint-disable-next-line -->
                    <span v-html="medIndicationsTherapeutiques" />
                  </div>
                </div>
              </div>

              <!-- conditions de prescription -->
              <div class="card shadow mb-4 ml-3 mr-3 w-100">
                <a
                  href="#conditionsPrescription"
                  class="d-block card-header py-3"
                  data-toggle="collapse"
                  role="button"
                  aria-expanded="true"
                  aria-controls="conditionsPrescription"
                >
                  <h6
                    class="m-0 font-weight-bold"
                    :class="medEtatCommercialisation ? 'text-success' : 'text-warning'"
                  >
                    Conditions de prescription
                  </h6>
                </a>

                <div
                  id="conditionsPrescription"
                  class="collapse"
                >
                  <div class="card-body text-left">
                    <!-- eslint-disable-next-line -->
                    <span v-html="medConditionsPrescription" />
                  </div>
                </div>
              </div>
            </div>

            <div class="row justify-content-center">
              <a
                :href="'http://base-donnees-publique.medicaments.gouv.fr/affichageDoc.php?specid=' + med.codeCIS + '&typedoc=R'"
                target="_blank"
                class="btn btn-info btn-icon-split"
              >
                <span class="icon text-white-50">
                  <i class="fas fa-info-circle" />
                </span>
                <span class="text">En savoir plus</span>
              </a>
            </div>
          </div>
          <div class="modal-footer">
            <div class="mr-auto">
              <a
                class="btn btn-success btn-icon-split disabled"
                :class="medEtatCommercialisation ? 'btn-success' : 'btn-warning'"
              >
                <span class="icon text-white-50">
                  <i
                    class="fas"
                    :class="medEtatCommercialisation ? 'fa-check' : 'fa-exclamation-triangle'"
                  />
                </span>
                <span class="text text-white">{{ medEtatCommercialisation ? 'Commercialisation active' : 'Déclaration arrêt commercialisation' }}</span>
              </a>
            </div>
            <a
              class="btn btn-light btn-icon-split"
              data-dismiss="modal"
            >
              <span class="icon text-gray-600">
                <i class="fas fa-arrow-right" />
              </span>
              <span class="text">Fermer</span>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Med',
  props: {
    med: {
      type: Object,
      default: () => {}
    },
  },
  computed: {
    favorites: function () {
      return this.$attrs.favorites
    },
    medPrice: function () {
      return this.med.presentations && this.med.presentations[0].prix ? this.med.presentations[0].prix.toFixed(2) + '€' : '?'
    },
    medShape: function () {
      return this.med.formePharmaceutique
    },
    medAdministration: function () {
      return this.med.voiesAdministration ? this.med.voiesAdministration[0] : '?'
    },
    medIndicationsTherapeutiques: function () {
      return this.med.indicationsTherapeutiques || 'Aucunes indications fournies...'
    },
    medConditionsPrescription: function () {
      let string = ''
      const conditions = this.med.conditionsPrescriptionDelivrance

      if (conditions && conditions.length) {
        conditions.forEach((condition) => {
          string += `<li>${this.capitalizeFirstLetter(condition)}</li>\n`
        })
      } else {
        string = 'Ce médicament ne possède pas de conditions de prescription particulières'
      }

      return string;
    },
    medEtatCommercialisation: function () {
      return this.med.etatCommercialisation
    },
    isInFavorites: function () {
      return this.favorites.find(favorite => favorite.codeCIS === this.med.codeCIS)
    }
  },
  methods: {
    capitalizeFirstLetter: function (string) {
      string = string.trim().toLowerCase()
      return string.charAt(0).toUpperCase() + string.slice(1);
    },
    toggleFavorite: function (e) {
      // if the medicine already is in user's favorites, remove it
      if (this.isInFavorites) {
        this.$http.delete(`${this.$apiUrl}/favorite/`).then(res => {
          // this.favorites = this.favorites.filter(favorite => favorite.codeCIS !== this.med.codeCIS)
          this.favorites.splice(this.favorites.map(fav => fav.codeCIS).indexOf(this.med.codeCIS), 1)
        }).catch(err => {
          console.error(err)
        })
      } else {
        const med = {
          codeCIS: this.med.codeCIS,
          denomination: this.med.denomination
        }
        this.$http.post(`${this.$apiUrl}/favorite/`, med).then(res => {
          this.favorites.push(med)
        }).catch(err => {
          console.error(err)
        })
      }
    }
  }
}
</script>

<style scoped>
</style>
