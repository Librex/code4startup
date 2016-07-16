class SubscriptionsController < ApplicationController
  def create
    Subscription.create_subscription(session[:project_id], current_user)
    redirect_to project_path(session[:project_id])
    session[:project_id] = nil
  end
end
