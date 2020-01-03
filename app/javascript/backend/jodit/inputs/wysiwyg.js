import $ from 'jquery';
import Jodit from 'jodit';

function initializeJoditWysiwygOnInputs() {
  $('textarea.wysiwyg').each(function () {
    new Jodit(this, {
      uploader: {
        headers: {
          'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')
        },
        url: '/admin/assets/wysiwyg'
      }
    });
  });
 }

$(document).on('turbolinks:load', function() {
  initializeJoditWysiwygOnInputs();
});
