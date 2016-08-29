# == Schema Information
#
# Table name: user_plans
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  plan_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserPlan < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  def self.create_user_plan(params, current_user)
    plan = Plan.find_by(amount: params)
    self.create(user_id: current_user.id, plan_id: plan.id)
  end
  def self.update_user_plan(current_user)
    update_user_plan = self.find_by(user_id: current_user.id)
    update_user_plan.plan_id = 2
    update_user_plan.save
  end
end
