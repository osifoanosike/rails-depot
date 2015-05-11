class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  belongs_to :order

  # def total_price
  #   product.price * quantity
  # end
  def modify_quantity(operation)
    if operation == "decrement"
      decrement!('quantity', 1)
    else
      increment!('quantity', 1)
    end
    self.save!
  end
end
