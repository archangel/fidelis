// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();

// Third party libraries
require('bootstrap');
require('cocoon/app/assets/javascripts/cocoon');

// Bootalert
require('backend/bootalert/defaults');
require('backend/bootalert/initialize');

// Flatpickr
require('backend/flatpickr/defaults');
require('backend/flatpickr/inputs/date_time_picker');

// Jodit
require('backend/jodit/defaults');
require('backend/jodit/inputs/wysiwyg');

// SortableJS
require('backend/sortablejs/collections/entries');

require('backend/sidebar_active');
require('backend/sidebar_toggle');

// Stylesheets
require('stylesheets/backend');

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
