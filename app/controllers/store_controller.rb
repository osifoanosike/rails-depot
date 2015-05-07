class StoreController < ApplicationController
  include StoreManager
  before_action :set_visit_count, only: [:index]

  def index
    console
    @products = Product.all
  end
end
