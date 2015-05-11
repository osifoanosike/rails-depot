class CreateAndPopulatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :name
    end

    payment_types = ["GTPAY", "GLOBAL PAY", "PAYPAL", "FIRSTPAY"]
    
    payment_types.each do |payment|
      PaymentType.create!(name: payment)
    end
  end
end
