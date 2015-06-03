class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only:[:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy, :package, :start_processing, :ship]
  skip_before_action :authorize, only: [:new, :create]
 
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.order(created_at: :desc)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
    else
      @order = Order.new
      @payment_types = PaymentType.all
      render layout: 'store'
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    #once the order has been completed, delete that cart.
    respond_to do |format|
      if @order.save
        Cart.destroy(Cart.find_by(id: @cart.id))#send an order confirmation email
        OrderNotifier.received(@order).deliver_now
        format.html { redirect_to store_url, notice: "Thanks for your order! we'll notify you as soon as it ships."  }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def ship
    # @order = Order.find_by(id: params[:id])
    @order.state_event = "ship"

    respond_to do |format|
      if @order.save
        OrderNotifier.shipped(@order).deliver_now
        format.html { redirect_to orders_url, notice: "Order ##{@order.id.to_s.rjust(9,'0')} has been successfully marked as shipped" }
      else
        format.html { redirect_to orders_url, alert: "Order could not marked as shipped! Please try again or contact admin" }
      end
    end 
  end


  def package
    @order.package

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order #{@order.id.to_s.rjust(9, '0')} has been marked as packaged" }
    end
  end

  def start_processing
    @order.process

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order #{@order.id.to_s.rjust(9, '0')} has been marked as processed" }
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :payment_type_id)
    end
end
