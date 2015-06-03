class AddUnitPriceToLineItems < ActiveRecord::Migration
  def up
    add_column :line_items, :unit_price, :decimal

    LineItem.all.each do |line_item|
      line_item.unit_price = line_item.product.price
      # related_product = Product.find()
      line_item.save
    end
  end

  def down
    remove_column :line_items, :unit_price
  end
end
