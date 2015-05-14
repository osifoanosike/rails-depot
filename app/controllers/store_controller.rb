class StoreController < ApplicationController
  include StoreManager
  include CurrentCart
  before_action :set_visit_count, only: [:index]
  before_action :set_cart
  skip_before_action :authorize

  def index
    # console
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale]), @products = Product.find_by(locale: params[:set_locale])
    else
      @products = Product.all
    end   
    render layout: 'store'
  end
end
