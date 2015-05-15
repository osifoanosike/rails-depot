// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/



function Store(catalogueItem) {
  this.catalogueItem = catalogueItem;
}

Store.prototype = {

  makeImageActionable: function(image) {
    image.parent().find('.add_to_cart_btn').click();
  },

  adEventHandlers: function() {
    var that = this;

    this.catalogueItem.find('img').on('click', function(){
      that.makeImageActionable($(this));
    });
  }
}

$(document).on('page:change', function(){
  var catalogueItem = $('#catalogue .catalogue-item')

  var store = new Store(catalogueItem);
  store.adEventHandlers();
});