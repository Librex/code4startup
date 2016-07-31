class PlansController < ApplicationController
  def index
    check = current_user.payments.last
    checks = current_user.payments.with_deleted
    if check.present?
      return @plans = Plan.all_showing_user if check.closed? && checks.already_registration.present?
      return @plans = Plan.all if check.closed?
      return redirect_to myprojects_path if check.unavailable?
      return @plans = Plan.all_showing_user if check.amount == ONLY_ONE_MONTH
      if check.amount == ALL_SHOW_MONTH
        current_user.subscriptions.create(project_id: session[:project_id])
        redirect_to project_path(session[:project_id])
        session[:project_id] = nil
        return
      end
    elsif check.blank? && checks.already_registration.present?
      @plans = Plan.all_showing_user
      return
    else
      @plans = Plan.all
      return
    end
  end
end
