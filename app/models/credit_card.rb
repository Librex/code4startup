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
#  token              :string           not null
#  webpay_customer_id :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class CreditCard < ActiveRecord::Base
  attr_accessor :card_number, :card_number, :cvc, :amount
  belongs_to :user
  def self.create_credit_card(current_user,user, params_token)
    credit_card = self.new(
      user_id: current_user.id,
      date: user.active_card.exp_month,
      year: user.active_card.exp_year,
      cc_type: user.active_card.type,
      last_digits: user.active_card.last4,
      name: user.active_card.name,
      token: params_token,
      webpay_customer_id: user.id
    )
    credit_card.save
  end

  def self.webpay_customer_create(credit_params, user, webpay)
    recursion = webpay.recursion.create(
     amount: credit_params,
     currency: "jpy",
     customer: user.id,
     period: :month,
     description: "定期購読料"
     )
  end
  def recursion_create(params_type)
    if params_type == "recursion.succeeded"
      # 決済成功のメールを送る
    end
  end
  def recursion_failed
    if params_type == "recursion.failed"
      availability = false
      # カードが有効ではないとメールを送る
    end
  end

  def webhook_customer_created
    # 顧客が新規登録された時のwebhookをキャッチ
    if params[:type] == "customer.created"
    end
  end
  def webhook_customer_update
    # 顧客が更新された時のwebhookをキャッチ
    if params[:type] == "customer.updated"
    end
  end
  def webhook_customer_delete
    # 顧客が削除された時のwebhookをキャッチ
    if params[:type] == "customer.deleted"
    end
  end
  def webhook_recursion_created
    # 定期課金が登録された時webhookキャッチ
    if params[:type] == "recursion_created"
    end
  end
  def webhook_recursion_failed
    if params[:type] == "recursion.failed"
    end
  end
end
