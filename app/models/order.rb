class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :payment_type
  validates :name, presence: true
  validates :email, presence: true
  validates :address, presence: true

  def add_line_items_from_cart(cart)
    # line_items = cart.line_items
    cart.line_items.each do |item|
      #the line items moves from the cart into the order
      item.cart_id = nil
      item.save!
      line_items << item
    end
    cart.save!
  end
end