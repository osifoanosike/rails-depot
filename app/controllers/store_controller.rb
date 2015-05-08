class StoreController < ApplicationController
  include StoreManager
  include CurrentCart
  before_action :set_visit_count, only: [:index]
  before_action :set_cart

  def index
    # console
    @products = Product.all
  end
end
