class CreditCardsController < ApplicationController
  before_action :set_webpay, only: [:create, :destroy, :retry]
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
    if current_user.payments.last.try(:amount) == ONLY_ONE_MONTH
      @webpay.recursion.delete(id: current_user.payments.last.webpay_recursion_id)
      User.delete_dependent(current_user)
    end
    # 顧客登録
    begin
      @user = @webpay.customer.create(card: params['webpay-token'])
      recursion = CreditCard.webpay_customer_create(credit_params['amount'], @user, @webpay)
      CreditCard.create_credit_card(current_user, @user)
      # クレジットカードが登録された後に中間テーブルのプランユーザテーブルが作成される
      UserPlan.create_user_plan(params[:credit_card][:amount], current_user)
      Subscription.create_subscription(session[:project_id], current_user)
      200
      redirect_to root_path
      # 顧客idも保存しておかないといけないかも(削除時に必要かもしれない)
    rescue WebPay::ErrorResponse::InvalidRequestError => e
      flash[:error] = e.message
      redirect_to root_path
    end
  end

  def destroy
    @webpay.recursion.delete(id: current_user.payments.first.webpay_recursion_id)
    User.delete_dependent(current_user)
    200
    redirect_to root_path
  end

  def retry
    begin
      Payment.card_retry(current_user, @webpay)
      redirect_to myprojects_path
    rescue => e
      logger.error e
      flash.notice = "こちらのカードが現在使えません"
      redirect_to myprojects_path
    end
  end

  private

  def check_plan_user
    return 400 if env['HTTP_X_WEBPAY_ORIGIN_CREDENTIAL'] != Settings.webpay.credential
    CreditCard.check_plan_user(params)
    200
    redirect_to root_path
  end

  def credit_params
    params.require(:credit_card).permit(:name, :year, :date, :cc_type, :token, :card_number, :amount)
  end

  def set_webpay
    @webpay = WebPay.new(Settings.webpay.access_key)
  end
end
