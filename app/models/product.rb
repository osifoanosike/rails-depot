class Product < ActiveRecord::Base
  validates :name, :description,  presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.00 }
  validates :name, uniqueness: true
  # validates :image_url, allow_blank: true, format: { with: , message: "Url must be in a valid format" }
end
