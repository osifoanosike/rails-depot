class CopyProductPriceIntoLineItems < ActiveRecord::Migration
  def up
    add_column :line_items, :total_price, :decimal, default: 0.00

    LineItem.all.each do |line_item|
      line_item.total_price = line_item.product.price * line_item.quantity
      line_item.save!
    end
  end

  def down
    remove_column :line_items, :total_price
  end
end
