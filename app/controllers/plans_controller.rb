class PlansController < ApplicationController
  def index
    check = current_user.payments.last
    if check.nil?
      @plans = Plan.all
    elsif check.amount == 1000
      @plans = Plan.all_showing_user
    elsif check.amount == 2000
      current_user.subscriptions.create(project_id: session[:project_id])
      redirect_to project_path(session[:project_id])
      session[:project_id] = nil
    end
  end
end
