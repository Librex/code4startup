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
      token: params["webpay-token"]
    )
    @credit_card.save
    # クレジットカードが登録された後に中間テーブルのプランユーザテーブルが作成される
    plan = Plan.find_by(amount: params[:credit_card][:amount])
    current_user.plan_users.create(plan_id: plan.id)
    # クレジットカードが登録された後に支払い方法が登録される
    current_user.payments.create(availability: true)
    redirect_to root_path
  end
  private

  def credit_params
    params.require(:credit_card).permit(:name, :year, :date, :cc_type, :token, :card_number, :amount)
  end
end
