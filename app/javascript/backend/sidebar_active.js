'use strict'

import $ from 'jquery'

function initializeSidebarActiveState () {
  var currentPath = window.location.pathname
  var rootPath = '/admin'

  $('#layoutSidenav_nav .sb-sidenav a.nav-link').each(function () {
    var isDashboardLink = (currentPath === rootPath &&
                            currentPath === this.pathname)
    var isNotDashboardLink = (currentPath !== rootPath &&
                               this.pathname !== rootPath &&
                               currentPath.startsWith(this.pathname))
    var isActive = isDashboardLink || isNotDashboardLink

    $(this).toggleClass('active', isActive)
  })
}

$(document).on('turbolinks:load', function () {
  initializeSidebarActiveState()
})
