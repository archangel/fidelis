import $ from 'jquery';

'use strict';

function initializeClickSidebarToggle() {
  $("#sidebarToggle").on("click", function(e) {
    e.preventDefault();

    $("body").toggleClass("sb-sidenav-toggled");
  });
}

$(document).on('turbolinks:load', function() {
  initializeClickSidebarToggle();
});
