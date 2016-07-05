class PlansController < ApplicationController
  def index
    check = current_user.plan_users.first
    if check.nil? || check.plan_id == 1 && check.count == 0
      @plans = Plan.all
    elsif check.plan_id == 1 && check.count > 0
      current_user.plan_users.first.count -= 1
      redirect_to project_path(session[:project_id])
      session[:project_id] = nil
    elsif check.plan_id == 2
      current_user.subscriptions.create(project_id: session[:project_id])
      redirect_to project_path(session[:project_id])
      session[:project_id] = nil
    end
  end
end
