class CreditCardsController < ApplicationController
  def new
    @credit_card = current_user.credit_cards.build
  end
  def create

  end
  private
  def credit_params

  end
end
