require 'ffaker'
FactoryGirl.define do
  factory :product do
    name { FFaker::Name.name }
    description "Product description"
    image_url "/test/product.png"
    price 0.00
  end
end
