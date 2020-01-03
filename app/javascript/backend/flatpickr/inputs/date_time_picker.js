import $ from 'jquery';
import flatpickr from 'flatpickr';

function initializeFlatpickrDatetimeOnInputs() {
  $('input.date_time_picker').each(function () {
    flatpickr(this, {
      allowInput: true,
      altInput: true,
      altFormat: 'm.d.y @ h:i K',
      dateFormat: 'Y-m-d H:i:00',
      enableTime: true
    });
  });
 }

$(document).on('turbolinks:load', function() {
  initializeFlatpickrDatetimeOnInputs();
});
