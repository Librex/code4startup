# == Schema Information
#
# Table name: credit_cards
#
#  id          :integer          not null, primary key
#  date        :string           not null
#  year        :string           not null
#  cc_type     :string           not null
#  last_digits :integer          not null
#  user_id     :integer          not null
#  name        :string           not null
#  token       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CreditCard < ActiveRecord::Base
  attr_accessor :card_number, :card_number, :cvc
  belongs_to :user
end
