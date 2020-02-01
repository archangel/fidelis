'use strict'

import $ from 'jquery'

function initializeClickSidebarToggle () {
  $('#sidebarToggle').on('click', function (e) {
    e.preventDefault()

    $('body').toggleClass('sb-sidenav-toggled')
  })
}

$(document).on('turbolinks:load', function () {
  initializeClickSidebarToggle()
})
