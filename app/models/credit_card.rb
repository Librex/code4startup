# == Schema Information
#
# Table name: credit_cards
#
#  id                 :integer          not null, primary key
#  date               :string           not null
#  year               :string           not null
#  cc_type            :string           not null
#  last_digits        :integer          not null
#  user_id            :integer          not null
#  name               :string           not null
#  webpay_customer_id :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  deleted_at         :datetime
#
# Indexes
#
#  index_credit_cards_on_deleted_at  (deleted_at)
#

class CreditCard < ActiveRecord::Base
  attr_accessor :card_number, :card_number, :cvc, :amount
  acts_as_paranoid
  belongs_to :user
  validates :user_id, presence: true
  validates :date, presence: true, numericality: true, length: { maximum: 2 }
  validates :year, presence: true, numericality: true, length: { maximum: 4 }
  validates :cc_type, presence: true
  validates :last_digits, presence: true, numericality: true
  validates :webpay_customer_id, presence: true

  def self.create_credit_card(current_user, user)
    credit_card = self.new(
      user_id: current_user.id,
      date: user.active_card.exp_month,
      year: user.active_card.exp_year,
      cc_type: user.active_card.type,
      last_digits: user.active_card.last4,
      name: user.active_card.name,
      webpay_customer_id: user.id
    )
    credit_card.save
  end

  def self.webpay_customer_create(credit_params, user, webpay)
    time = Time.now.months_ago(1) + 2.minute
    recursion = webpay.recursion.create(
     amount: credit_params,
     currency: "jpy",
     customer: user.id,
     period: :month,
     first_scheduled: Time.parse("#{time}").to_i,
     description: "定期購読料"
     )
  end

  def self.check_plan_user(params)
    if params[:type] == 'recursion.failed'
      credit_card = self.find_by(webpay_customer_id: params[:data][:object][:customer])
      if params[:data][:object][:status] == "suspended"
        Subscription.where(user_id: credit_card.user_id).update_all(deleted_at: Time.now)
        Payment.create(user_id: credit_card.user_id, status: 1, amount: params[:data][:object][:amount], webpay_recursion_id: params[:data][:object][:id])
      end

      if params[:data][:object][:status] == "closed"
        Subscription.where(user_id: credit_card.user_id).update_all(deleted_at: Time.now)
        Payment.create(user_id: credit_card.user_id, status: 2, amount: params[:data][:object][:amount], webpay_recursion_id: params[:data][:object][:id])
      end
    end

    if params[:type] == 'recursion.succeeded'
      credit_card = CreditCard.find_by(webpay_customer_id: params[:data][:object][:customer])
      self.update_subscription(credit_card.user_id)
      Payment.create(user_id: credit_card.user_id, status: 0, amount: params[:data][:object][:amount], webpay_recursion_id: params[:data][:object][:id])
    end
  end

  def self.update_subscription(user)
    Subscription.where(user_id: user).with_deleted.update_all(deleted_at: nil)
    # Payment.where(user_id: user).with_deleted.update_all(deleted_at: nil)
  end
end
