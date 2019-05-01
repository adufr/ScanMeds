


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
              {{ med.denomination }}
            </h5>
            <button
              type="button"
              class="close"
              data-dismiss="modal"
              aria-label="Close"
            >
              <span aria-hidden="true">&times;</span>
            </button>
          </div>

          <div class="modal-body">
            <div class="row">
              <!-- price card -->
              <div class="col-xl mb-3">
                <div class="card border-left-success shadow h-100 py-2">
                  <div class="card-body">
                    <div class="row no-gutters align-items-center">
                      <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
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
                <div class="card border-left-success shadow h-100 py-2">
                  <div class="card-body">
                    <div class="row no-gutters align-items-center">
                      <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
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
                <div class="card border-left-success shadow h-100 py-2">
                  <div class="card-body">
                    <div class="row no-gutters align-items-center">
                      <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
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
          </div>

          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-dismiss="modal"
            >
              Fermer
            </button>
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
    }
  },
  computed: {
    medPrice: function () {
      return this.med.presentations && this.med.presentations[0].prix ? this.med.presentations[0].prix.toFixed(2) + '€' : '?'
    },
    medShape: function () {
      return this.med.formePharmaceutique
    },
    medAdministration: function () {
      return this.med.voiesAdministration ? this.med.voiesAdministration[0] : '?'
    }
  }
}
</script>

<style scoped>
</style>
