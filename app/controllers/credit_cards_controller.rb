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
    CreditCard.create_credit_card(current_user, @user)
    # クレジットカードが登録された後に中間テーブルのプランユーザテーブルが作成される
    UserPlan.create_user_plan(params[:credit_card][:amount], current_user)
    Subscription.create_subscription(session[:project_id], current_user)
    # クレジットカードが登録された後に支払い方法が登録される
    Payment.create_payment(recursion, current_user, params[:credit_card][:amount])
    redirect_to root_path
  end

  def destroy
    @webpay.recursion.delete(id: current_user.payments.first.webpay_recursion_id)
    User.delete_dependent(current_user)
    redirect_to root_path
  end

  private

  def check_plan_user
    return 400 if env["HTTP_X_WEBPAY_ORIGIN_CREDENTIAL"] != Settings.webpay.credential
  event = JSON.parse(request.body.read)
  if event["type"] == "customer.created"
    # 顧客が作成された時に行いたい処理をここに入れる
  end
    # charge.failed
    if params[:type] == 'recursion.failed'
      credit_card = CreditCard.find_by(webpay_customer_id: params[:data][:object][:customer])
      Payment.create(user_id: credit_card.user_id, status: 1, amount: params[:data][:object][:amount], webpay_recursion_id: params[:data][:object][:id])
    end

    if params[:type] == 'recursion.succeeded'
      credit_card = CreditCard.find_by(webpay_customer_id: params[:data][:object][:customer])
      Payment.create(user_id: credit_card.user_id, status: 0, amount: params[:data][:object][:amount], webpay_recursion_id: params[:data][:object][:id])
    end
    200
    redirect_to root_path
    # return 400 if env["HTTP_X_WEBPAY_ORIGIN_CREDENTIAL"] != Settings.webpay.credential
    # ログインユーザに紐づく中間テーブルが存在するか確認
    # 最後に登録したクレジットカード情報のお客さんidを取得
    # plan_idが1だったら処理を実行
    # 最後に支払いしたものが1かつ今回選択されたものが2ならグレードアップ
    # 1の人が追加課金で購入はできない
    # if current_user.user_plans.present?
    #   user = current_user.credit_cards.last.webpay_customer_id
    #   if current_user.user_plans.first.plan_id == 1
    #     @webpay.recursion.delete(id: current_user.payments.last.webpay_recursion_id)
    #     current_user.payments.last.destroy
    #     @user = @webpay.customer.retrieve(user.to_s)
    #     recursion = CreditCard.webpay_customer_create(credit_params['amount'], @user, @webpay)
    #     CreditCard.create_credit_card(current_user, @user)
    #     Payment.create_payment(recursion, current_user, credit_params['amount'])
    #     UserPlan.update_user_plan(current_user)
    #     Subscription.create_subscription(session[:project_id], current_user)
    #     session[:project_id] = nil
    #     return redirect_to root_path
    #   end
    # end
  end

  def credit_params
    params.require(:credit_card).permit(:name, :year, :date, :cc_type, :token, :card_number, :amount)
  end

  def set_webpay
    @webpay = WebPay.new(Settings.webpay.access_key)
  end
end
