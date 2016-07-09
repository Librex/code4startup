# == Schema Information
#
# Table name: payments
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  purchase_date       :string
#  availability        :boolean
#  continuation        :integer
#  expire_date         :date
#  webpay_recursion_id :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  def self.create_payment(recursion, current_user)
    self.create(availability: true, webpay_recursion_id: recursion.id, user_id: current_user.id)
  end
end