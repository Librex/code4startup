# == Schema Information
#
# Table name: payments
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  error_log           :text
#  status              :integer          not null
#  webpay_recursion_id :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  deleted_at          :datetime
#  amount              :integer
#
# Indexes
#
#  index_payments_on_deleted_at  (deleted_at)
#

class Payment < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  belongs_to :plan
  validates :user_id, presence: true
  validates :status, presence: true
  validates :webpay_recursion_id, presence: true
  validates :amount, presence: true
  validates :amount, numericality: true

  enum status: { availability: 0, unavailable: 1, closed: 2 }
  def self.create_payment(recursion, current_user, amount)
    self.create(webpay_recursion_id: recursion.id, user_id: current_user.id, status: 0, amount: amount)
  end
end
