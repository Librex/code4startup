class PlansController < ApplicationController
  def index
    @plans = Plan.all    
  end
  def new
  end

  def create
  end
end
