'use strict'

import $ from 'jquery'
import bootalert from 'bootalert'

function initializeFlashMessages () {
  $('.alert-message').each(function () {
    var alertText = $(this).text()
    var alertType = $(this).data('flash')

    // Add alert
    bootalert[alertType]($.trim(alertText))

    // Remove flash message
    $(this).remove()
  })
}

$(document).on('turbolinks:load', function () {
  initializeFlashMessages()
})
