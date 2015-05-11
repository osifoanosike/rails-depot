require 'rails_helper'

RSpec.describe PaymentType, type: :model do
  let(:payment_type) { FactoryGirl.create(:payment_type) }
  subject { payment_type }

  it { should respond_to :name }
  it { should validate_presence_of :name }
end
