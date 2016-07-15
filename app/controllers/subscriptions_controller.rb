class SubscriptionsController < ApplicationController
  def create
    binding.pry
    Subscription.create_subscription(session, current_user)
  end
end
