class CreditCardsController < ApplicationController
  def new
    # params[:format]でプランのidが入ってい
    @plan = Plan.find(params[:format])
    @credit_card = current_user.credit_cards.build
  end
  def create
    @webpay = WebPay.new(Settings.webpay.access_key)
    @user = @webpay.charge.create(amount: credit_params["amount"].to_i, currency: "jpy", card: params['webpay-token'])
    @credit_card = current_user.credit_cards.build(
      date: @user.card.exp_month,
      year: @user.card.exp_year,
      cc_type: @user.card.type,
      last_digits: @user.card.last4,
      name: @user.card.name,
      token: params["webpay-token"],
    )
    @credit_card.save
    redirect_to root_path
  end
  private
  def credit_params
    params.require(:credit_card).permit(:name, :year, :date, :cc_type, :token, :card_number, :amount)
  end
end
