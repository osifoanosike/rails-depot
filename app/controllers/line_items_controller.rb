class LineItemsController < ApplicationController
  include CurrentCart
  include StoreManager
  before_action :set_cart, only: [:create, :destroy, :increment, :decrement]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy, :increment, :decrement]
  after_action :reset_visit_count, only: [:create]
  skip_before_action :authorize, only: [:create, :destroy]


  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find_by(id: params[:product_id])
    @line_item = @cart.add_product(product.id)
    @line_item.set_unit_price
    
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url, notice: 'Item was added to cart successfully.' }
        format.js { @current_item = @line_item } #this sends along the created item to the js file
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to store_url } #cart_url(@line_item.cart) }
      format.js
      format.json { head :no_content }
    end
  end

  def increment
    @line_item.modify_quantity("increment")
    @cart.update_line_item_price(@line_item, "increment")

    respond_to do |format|
      format.html { redirect_to store_url }
      format.js
    end
  end

  def decrement
    @line_item.modify_quantity("decrement")
    @cart.update_line_item_price(@line_item, "decrement")
    unless @line_item.quantity == 0
      respond_to do |format|
        format.html { redirect_to store_url }
        format.js { @item_count = @line_item.quantity }
      end
    else
      @line_item.destroy
      respond_to do |format|
        format.js { render action: "destroy.js.erb" }
      end
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # def set_cart
    #   @cart = Cart.find_by(id: session[:cart_id]) 
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item)
    end
end
