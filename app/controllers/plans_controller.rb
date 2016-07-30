class PlansController < ApplicationController
  def index

    check = current_user.payments.last
    checks = current_user.payments.with_deleted
    # ユーザが初めてサービスに登録した時はプランはすべて選べる

    if check.present?
      return @plans = Plan.all_showing_user if check.status == "closed" && checks.where(amount: 2000, status: 0).present?
      return @plans = Plan.all if check.status == "closed"
      return redirect_to myprojects_path if check.status == "unavailable"
      return @plans = Plan.all_showing_user if check.amount == ONLY_ONE_MONTH
      if check.amount == ALL_SHOW_MONTH
        current_user.subscriptions.create(project_id: session[:project_id])
        redirect_to project_path(session[:project_id])
        session[:project_id] = nil
        return
      end
    elsif check.blank? && checks.where(amount: 2000, status: 0).present?
      @plans = Plan.all_showing_user
      return
    else
      @plans = Plan.all
      return
    end
    # 1000円プランに入っていると2000円プランしか選べない
    # 2000円のプランに入っているとそのままサービスを登録できる
    # 過去に2000円のプランに入っていた場合再登録する際は2000円プランしか選べない
    # 過去のプランが1000円だと両方選ぶことができる
    #
    # if checks.present?
    #   if check.amount == ALL_SHOW_MONTH
    #     current_user.subscriptions.create(project_id: session[:project_id])
    #     redirect_to project_path(session[:project_id])
    #     session[:project_id] = nil
    #     return
    #   end
    # elsif
    #   @plans = Plan.all
    #   return
    # end
    #
    # if check.nil? && current_user.payments.with_deleted.where(amount: 2000, status: 0).present?
    #   @plans = Plan.all_showing_user
    #   return
    # end
    # if check.nil? || check.status == "closed" && check.amount == ONLY_ONE_MONTH
    #   @plans = Plan.all
    #   return
    # end
    #
    # if check.status == "unavailable"
    #   redirect_to myprojects_path
    # elsif check.status != "availability" && check.amount == 2000
    #   @plans = Plan.all
    #   return
    # end
    #
    # if check.amount == ONLY_ONE_MONTH
    #   @plans = Plan.all_showing_user
    #   return
    # elsif check.amount == ALL_SHOW_MONTH
    #   current_user.subscriptions.create(project_id: session[:project_id])
    #   redirect_to project_path(session[:project_id])
    #   session[:project_id] = nil
    # end
  end
end
