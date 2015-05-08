require 'rails_helper'

RSpec.describe "line_items/new", type: :view do
  before(:each) do
    assign(:line_item, LineItem.new(
      :cart => nil,
      :product => nil
    ))
  end

  it "renders new line_item form" do
    render

    assert_select "form[action=?][method=?]", line_items_path, "post" do

      assert_select "input#line_item_cart_id[name=?]", "line_item[cart_id]"

      assert_select "input#line_item_product_id[name=?]", "line_item[product_id]"
    end
  end
end