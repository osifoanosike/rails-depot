class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_line_item = line_items.find_by(product_id: product_id)

    if current_line_item #if the line item already exists, increment it
      current_line_item.quantity += 1
    else
      #create a new line_item for that product
      current_line_item = line_items.build(product_id: product_id) #same as self.line_items.build
    end

    update_line_item_price(current_line_item, "increment")
    current_line_item
  end

  def update_line_item_price(line_item, update_type)
    if(update_type == "increment")
       line_item.total_price += line_item.product.price
    else
       line_item.total_price -= line_item.product.price
    end
    line_item.save!
  end

  def total_amount
    line_items.to_a.sum { |item| item.total_price }
  end
end
