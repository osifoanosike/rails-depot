class UpdateOrdersWithPaymentType < ActiveRecord::Migration
  def up
    Order.all.each do |order|
      order.payment_type_id = PaymentType.first.id     
      order.save!
    end
  end

  def down
    Order.all.each do |order|
      order.payment_type_id = nil
    end
  end
end
