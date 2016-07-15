require 'spec_helper'
describe CreditCard do
  let(:params) { {amount: 1000, currency: 'jpy', card: 'tok_xxxxxxxxx', description: 'test charge'} }
  let!(:response) { webpay_stub(:charges, :create , params: params) })
  describe '値が身体ったら身体ったら' do

  end
end
