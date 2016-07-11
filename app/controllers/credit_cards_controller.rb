class CreditCardsController < ApplicationController
  before_action :set_webpay, only: [:create, :destroy]
  before_action :check_plan_user, only: [:create]
  protect_from_forgery except: :create

  def index
    redirect_to root_path
  end

  def new
    # params[:format]でプランのidが入ってい
    @plan = Plan.find(params[:format])
    @credit_card = current_user.credit_cards.build
  end

  def create
    # 顧客登録
    @user = @webpay.customer.create(card: params['webpay-token'])
    # 顧客idも保存しておかないといけないかも(削除時に必要かもしれない)
    recursion = CreditCard.webpay_customer_create(credit_params['amount'], @user, @webpay)
    CreditCard.create_credit_card(current_user, @user, params['webpay-token'])
    # クレジットカードが登録された後に中間テーブルのプランユーザテーブルが作成される
    PlanUser.create_plan_user(params[:credit_card][:amount], current_user)
    Subscription.create_subscription(session[:project_id], current_user)
    # クレジットカードが登録された後に支払い方法が登録される
    Payment.create_payment(recursion, current_user)
    redirect_to root_path
  end

  def destroy
    @webpay.recursion.delete(id: current_user.payments.first.webpay_recursion_id)
    User.delete_dependent(current_user)
    redirect_to root_path
  end

  private

  def check_plan_user
    if params[:type] == 'recursion.failed'
      credit_card = CreditCard.find_by(webpay_customer_id: params[:data][:object][:customer])
      payment = Payment.find_by(user_id: credit_card.user_id)
      payment.availability = false
      payment.save
    end
    if params[:type] == 'recursion.succeeded'
      credit_card = CreditCard.find_by(webpay_customer_id: params[:data][:object][:customer])
       Subscription.create_subscription(1, credit_card) if Subscription.where(user_id: credit_card.user_id).count >= 1
       plan_user = PlanUser.find_by(user_id: credit_card.user_id)
       plan_user.count += 1 if plan_user.plan_id == 1
       plan_user.save
    end
    # return 400 if env["HTTP_X_WEBPAY_ORIGIN_CREDENTIAL"] != Settings.webpay.credential
    if current_user.plan_users.present?
      user = current_user.credit_cards.first.webpay_customer_id
      if current_user.plan_users.first.plan_id == 1
        @webpay.recursion.delete(id: current_user.payments.first.webpay_recursion_id)
        current_user.payments.first.delete
        @user = @webpay.customer.retrieve(user.to_s)
        recursion = CreditCard.webpay_customer_create(credit_params['amount'], @user, @webpay)
        CreditCard.create_credit_card(current_user, @user, params['webpay-token'])
        Payment.create_payment(recursion, current_user)
        PlanUser.update_plan_user(current_user)
        Subscription.create_subscription(session[:project_id], current_user)
        session[:project_id] = nil
        return redirect_to root_path
      end
    end
  end

  def credit_params
    params.require(:credit_card).permit(:name, :year, :date, :cc_type, :token, :card_number, :amount)
  end

  def set_webpay
    @webpay = WebPay.new(Settings.webpay.access_key)
  end
end
