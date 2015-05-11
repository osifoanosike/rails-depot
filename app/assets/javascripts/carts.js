// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// click_checkout -> 
//   $('a.checkout').click() ->
//   $('#action-section').css('disabled', 'disabled');

function Cart(checkoutBtn, actionSection) {
  this.checkoutBtn = checkoutBtn;
  this.actionSection = actionSection;
}

Cart.prototype = {

  adEventHandlers: function(){
    var that = this;
    this.checkoutBtn.on('click', function(){
      alert("yeah");
      that.actionSection.attr('disabled', 'disabled').off('click');
    });
  }
}

$(document).ready(function(){
  var checkoutBtn = $('a.checkout');
  var actionSection = $('.action-section');
  console.log(actionSection);
  
  cart  = new Cart(checkoutBtn, actionSection);
  
  cart.adEventHandlers();
});