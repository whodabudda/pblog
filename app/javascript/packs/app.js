/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import "core-js/stable";
import "regenerator-runtime/runtime";
//require("@rails/ujs").start()
//require("turbolinks").start()
//require("jquery") may already be loaded through environment.js
//require("tether")
//window.$ = $;
//window.jQuery = jQuery;
import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;

import Ujs from "@rails/ujs"
import Turbolinks from "turbolinks"
Ujs.start()
Turbolinks.start()
import "tether"
import "bootstrap" 
import "stylesheets" 
import "social-share-button"

console.log('Hello World from Webpacker')
