require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.create(:order) }
  subject { order }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:address) } 
  it { should respond_to(:pay_type) } 

  
  #association
  it { should have_many(:line_items) }
  it { should be_valid }

  #validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:address) }
  it { should validate_inclusion_of(:pay_type).in_array(["GT PAY", "ETRANZACT","ZENITH GLOBAL PAY", "VISA"]) }
end
