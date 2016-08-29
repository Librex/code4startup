require 'rails_helper'

RSpec.describe PlansController, :type => :controller do
  let(:user) { create(:user) }

  describe '#index' do
    it '最後に支払いしたものが存在しなければすべてのプランを表示' do
      get :index
    end
  end
end
