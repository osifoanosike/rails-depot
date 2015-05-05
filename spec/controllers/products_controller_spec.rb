require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  #i write the tests for all my get methods
  describe "GET #index" do
    before(:each) do 
      @product = FactoryGirl.create :product
      get :index
    end

    it "populates an array of products" do
      assigns(:products).should eq([@product])
    end

    it "renders the index view" do
      response.should render_template :index
    end
  end

  describe "GET #new" do
    before do
      @product = FactoryGirl.create :product
      get :show, id: @product.id
    end

    it "returns the product" do
      assigns(:product).should eql(@product)
    end

    it "renders the show view" do
      response.should render_template :show
    end
  end

  describe "GET #new" do
    before do
      get :new
    end

    it "renders the new template" do
      response.should render_template :new
    end
  end


  #tests POST methods
  describe "POST #create" do
    context "when product is created successfully" do
      before do
        @product_attr = FactoryGirl.attributes_for(:product)
      end

      it "should create the product" do
        expect{
          post :create, product: @product_attr
        }.to change(Product, :count).by(1)
      end

      it "renders the newly created view after creation" do
        post :create, { product: @product_attr }
        expect(response).to redirect_to Product.last
      end
    end

    context "when product creation fails" do
      before do 
        @product_attr = FactoryGirl.attributes_for(:product) #this product is invalid 
        @product_attr['name'] = ""
      end

      it "should not create the product" do
       expect{ post :create, product: @product_attr }.not_to change(Product, :count)
      end
    end
  end

  #tests product update
  describe "PUT #update" do
    before(:each) do 
      @product = FactoryGirl.create(:product, name: "productX")
    end
    context "on successful update" do
      it "should update the product's name" do
        put :update, id: @product.id , product: { name: "updated product name" }
        @product.reload
        expect(@product.name).to eql("updated product name")
      end
    end

    context "when update fails" do
      before(:each) do
        put :update, id: @product.id , product: { name: "" }
        @product.reload
      end

      it "should leave the product unchanged" do
        expect(@product.name).to eql("productX")
      end
      
    end
  end

  #test product deletion
  describe "DELETE #destroy" do
    before do
      @product = FactoryGirl.create(:product)
    end

    it "should delete the product successfully" do
      expect{ delete :destroy, id: @product.id }.to change(Product, :count).by(-1)
    end

    it "should redirect to the  index view after deletion" do
      delete :destroy, id: @product.id
      expect(response).to redirect_to products_url
    end
  end
end
