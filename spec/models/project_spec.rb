require 'rails_helper'

describe Project do
  describe '#self.looking_count' do
    example '自分に紐づく購入履歴がなければfalse' do
      user = create(:user)
    end
  end
end
