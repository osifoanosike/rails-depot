class Product < ActiveRecord::Base
  validates :name, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.00 }
  validates :name, uniqueness: true
  # validates :image_url, allow_blank: true, format: { with: , message: "Url must be in a valid format" }
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_no_related_line_items

  def self.latest 
    Product.order('updated_at').last #this returns the last updated item
  end

  def ensure_no_related_line_items
    if line_items.empty?
      true
    else  
      errors.add(:base, 'This product has existing line items')
      false      
    end
  end

  def filter(filter_params)
    filter_params.each do |param, value|
      filter_string += "and #{param} LIKE #{value}"
    end

    Product.where(filter_string.sub(/and/, ''))
  end
end
