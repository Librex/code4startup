require 'spec_helper'
describe CreditCard do
  let(:user) { create(:user) }
  describe '#self.create_credit_card' do
    let(:params_hash) { attributes_for(:credit_card) }
    example '下四桁が4桁なら成功' do
      credit_card = CreditCard.new(params_hash, user_id: user.id)
      expect(credit_card.last_digits).to eq(4242)
    end
    example '下四桁が空白ならエラー' do
      credit_card = CreditCard.new(params_hash, user_id: user.id, last_digits: nil)
      expect(credit_card).to be_invalid
    end
    example 'dateが2桁以上だとエラー' do
      credit_card = CreditCard.new(params_hash)
      credit_card.date = 1000
      expect(credit_card).to be_invalid
    end
    example 'dateが1桁だと成功' do
      credit_card = CreditCard.new(params_hash)
      credit_card.date = 1
      expect(credit_card).to be_truthy
    end
  end
end
