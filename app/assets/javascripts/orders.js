function CheckoutView(cartActions, lineItemActions) {
  this.cartActions = cartActions;
  this.lineItemActions = lineItemActions;
}

CheckoutView.prototype = {

  hideCtrls: function() {
    if(window.location.pathname == "/orders/new" || window.location.pathname == "/en/orders/new") {
      this.cartActions.css('display', 'none');
      this.lineItemActions.css('display', 'none');
    }
  }
}

$(document).on("page:change", function(){
  var cartActions = $('#cart-section .action-section');
  var lineItemActions = $('#cart-section .item-action');
  checkoutView  = new CheckoutView(cartActions, lineItemActions);
  
  checkoutView.hideCtrls();
});