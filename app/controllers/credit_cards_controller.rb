class CreditCardsController < ApplicationController
  before_action :set_webpay, only: [:create, :destroy]
  def new
    # params[:format]でプランのidが入ってい
    @plan = Plan.find(params[:format])
    @credit_card = current_user.credit_cards.build
  end
  def create
    @webpay = WebPay.new(Settings.webpay.access_key)
    # @user = @webpay.charge.create(amount: credit_params["amount"].to_i, currency: "jpy", card: params['webpay-token'])
    # 顧客登録
    @user = @webpay.customer.create(card: params["webpay-token"])
    # 顧客idも保存しておかないといけないかも(削除時に必要かもしれない)
    recursion = @webpay.recursion.create(
     amount: credit_params["amount"].to_i,
     currency: "jpy",
     customer: @user.id,
     period: :month,
     description: "定期購読料"
     )

    @credit_card = current_user.credit_cards.build(
      date: @user.active_card.exp_month,
      year: @user.active_card.exp_year,
      cc_type: @user.active_card.type,
      last_digits: @user.active_card.last4,
      name: @user.active_card.name,
      token: params["webpay-token"],
      webpay_customer_id: @user.id
    )
    @credit_card.save
    # クレジットカードが登録された後に中間テーブルのプランユーザテーブルが作成される
    plan = Plan.find_by(amount: params[:credit_card][:amount])
    current_user.plan_users.create(plan_id: plan.id)
    # クレジットカードが登録された後に支払い方法が登録される
    current_user.payments.create(availability: true, webpay_recursion_id: recursion.id)
    redirect_to root_path
  end
  def destroy
    @webpay.recursion.delete(id: current_user.payments.first.webpay_recursion_id)
    current_user.credit_cards.first.delete
    current_user.payments.first.delete
    redirect_to root_path
  end
  private

  def credit_params
    params.require(:credit_card).permit(:name, :year, :date, :cc_type, :token, :card_number, :amount)
  end
  def set_webpay
    @webpay = WebPay.new(Settings.webpay.access_key)
  end
end
