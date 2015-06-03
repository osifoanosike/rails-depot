class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :payment_type
  validates :name, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :payment_type, presence: true
  validates_associated :payment_type

  scope :open_orders, -> { with_state(:open) } 
  scope :processed_orders, -> { with_state(:processed) }
  scope :packaged_orders, -> { with_state(:packaged) }
  scope :shipped_orders,  -> { with_state(:shipped) }

  state_machine initial: :open do
    event :process do
      transition :open => :processed
    end

    event :package do
      transition :processed => :packaged
    end

    event :ship do
      transition :packaged => :shipped
    end


    before_transition :packaged => :shipped do |order|
      order.is_shippable?
      #order.mark_as_shipped!
    end

    state :shipped do
      # debugger
    end

  end


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

  def mark_as_shipped!
    self.ship_date = Date.today
  end
end