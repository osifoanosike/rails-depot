FactoryGirl.define do
  factory :order do
    name { FFaker::Name.name }
    address { FFaker::Address.street_name }
    email { FFaker::Internet.email }
    payment_type 1
  end
end