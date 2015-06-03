class PaymentType < ActiveRecord::Base
  # validates :name, presence: true
  validates :id, presence: true
  has_many :orders
end
