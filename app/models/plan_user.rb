# == Schema Information
#
# Table name: plan_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  plan_id    :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PlanUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  def self.create_plan_user(params, current_user)
    plan = Plan.find_by(amount: params)
    plan.id == 1 ? self.create(plan_id: plan.id, count: 0, user_id: current_user.id) : current_user.plan_users.create(plan_id: plan.id, user_id: current_user.id)
  end
  def self.update_plan_user(current_user)
    update_plan_user = self.find_by(user_id: current_user.id)
    update_plan_user.plan_id = 2
    update_plan_user.save
  end
end
