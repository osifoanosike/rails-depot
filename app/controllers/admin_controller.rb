class AdminController < ApplicationController
  def index
    if User.is_first_user?
      redirect_to new_user_url, notice: "Please create an administrator"
    else
      @total_orders = Order.count
    end
  end
end
