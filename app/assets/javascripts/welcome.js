# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('.ckeditor').ckeditor({
  // optional config
});

$(function(){
   $("a.embed").oembed();
});

$(document).ready(function () {
    $('.dropdown-toggle').dropdown();
});


