import $ from 'jquery';
import bootalert from 'bootalert';

bootalert.options.closeButton = true;
bootalert.options.closeHtml = '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
bootalert.options.extendedTimeOut = 3000;
bootalert.options.iconClass = 'fa-info';
bootalert.options.iconClasses = {
                                  error: 'fa-times',
                                  info: 'fa-info',
                                  success: 'fa-check',
                                  warning: 'fa-exclamation'
                                };
bootalert.options.iconHtml = '<div class="bootalert-icon"><i class="fas fa-2x"></i></div>';
bootalert.options.timeOut = 8000;

function initializeFlashMessages() {
  $('.alert-message').each(function() {
    var alertText = $(this).text(),
        alertType = $(this).data('flash');

    // Add alert
    bootalert[alertType]($.trim(alertText));

    // Remove flash message
    $(this).remove();
  });
}

$(document).on('turbolinks:load', function() {
  initializeFlashMessages();
});
