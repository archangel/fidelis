import $ from "jquery";

"use strict";

function initializeSidebarActiveState() {
  var currentPath = window.location.pathname,
      rootPath = "/admin";

  $("#layoutSidenav_nav .sb-sidenav a.nav-link").each(function() {
    var isDashboardLink = (currentPath == rootPath &&
                            currentPath == this.pathname),
        isNotDashboardLink = (currentPath != rootPath &&
                               this.pathname != rootPath &&
                               currentPath.startsWith(this.pathname)),
        isActive = isDashboardLink || isNotDashboardLink;

    $(this).toggleClass("active", isActive);
  });
}

$(document).on("turbolinks:load", function() {
  initializeSidebarActiveState();
});
