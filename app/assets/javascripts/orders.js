function CheckoutView(checkoutBtn, emptyCartBtn) {
  this.checkoutBtn = checkoutBtn;
  this.emptyCartBtn = emptyCartBtn;
}

CheckoutView.prototype = {

  disable_checkout: function() {
    if(window.location.pathname == "/orders/new") {
      this.checkoutBtn.attr('disabled', 'true');
      this.emptyCartBtn.attr('disabled', 'true');
    }
  }
}

$(document).on("page:change", function(){
  var checkoutBtn = $('a.checkout');
  var emptyCartBtn = $('.empty_cart_btn');
  checkoutView  = new CheckoutView(checkoutBtn, emptyCartBtn);
  
  checkoutView.disable_checkout();
});