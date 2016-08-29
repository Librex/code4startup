require 'rails_helper'

describe Payment do
  # let!(:response) { webpay_stub(:charges, :create , params: params) })
  describe '#self.create_payment' do
    example 'statusが0なら課金が成功' do
      user = create(:user)
      amount = 1000
      payment = Payment.create_payment(user, user, amount)
      expect(payment.status).to eq('availability')
    end
    example 'statusが1なら一時停止' do
      user = create(:user)
      amount = 1000
      payment = Payment.create
    end
  end
end
