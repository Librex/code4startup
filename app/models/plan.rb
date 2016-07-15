# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  name       :string
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Plan < ActiveRecord::Base
  has_many :plan_users
  has_many :users, through: :plan_users
  scope :one_show_user, -> { where(amount: 1000) }
  scope :all_showing_user, -> { where(amount: 2000) }
end
