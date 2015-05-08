// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready', function(){
  //alert("the page has loaded");
  $('#catalogue .catalogue-item .product_image').on('click', function(){
    $(this).parent().find('button').click();
  });
});