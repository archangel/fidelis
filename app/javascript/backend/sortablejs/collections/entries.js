'use strict'

import $ from 'jquery'
import Sortable from 'sortablejs'
import bootalert from 'bootalert'

function initializeSortablejsOnCollectionEntries () {
  $('.table-sortable tbody').each(function () {
    Sortable.create(this, {
      animation: 150,
      dataIdAttr: 'data-sortable-id',
      direction: 'vertical',
      ghostClass: 'sortable-ghost',
      handle: '.sortable-handle',
      onUpdate: function () {
        var updatedPositions = this.toArray()
        var sortUrl = window.location.pathname + '/sort'

        $.ajax({
          data: {
            collection_entry: {
              positions: updatedPositions
            }
          },
          dataType: 'json',
          headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
          },
          method: 'POST',
          url: sortUrl
        })
          .done(function (data) {
            var message = data.message || 'Success'

            bootalert.success(message, { icon: 'fas fa-check fa-2x' })
          }).fail(function (evt) {
            var message = evt.responseJSON.error || 'Failure'

            bootalert.error(message, { icon: 'fas fa-dumpster-fire fa-2x' })
          })
      }
    })
  })
}

$(document).on('turbolinks:load', function () {
  initializeSortablejsOnCollectionEntries()
})
