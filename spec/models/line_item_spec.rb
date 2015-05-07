require 'rails_helper'

RSpec.describe LineItem, type: :model do

  describe "POST #create" do
    before(:each) do
      product = FactoryGirl.create(:product)
      cart = FactoryGirl.create(:cart)

      post :create, product_id: @product.id
    end
  end

end
