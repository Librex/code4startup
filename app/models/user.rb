# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  provider               :string
#  uid                    :string
#  image                  :string
#  student_flg            :boolean
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  validates :name, presence: true, length: { maximum: 25 }

  has_many :subscriptions
  has_many :projects, through: :subscriptions
  has_many :credit_cards
  has_many :reviews
  has_many :payments
  has_many :plans, through: :user_plans
  has_many :user_plans

  scope :beginning_10_people, -> {order('created_at desc').first(10)}

  def self.delete_dependent(current_user)
    Subscription.where(user_id: current_user.id).update_all(deleted_at: Time.now)
    CreditCard.where(user_id: current_user.id).delete_all
    UserPlan.where(user_id: current_user.id).delete_all
    Payment.where(user_id: current_user.id).update_all(deleted_at: Time.now)
  end

  def self.find_for_google_oauth2(access_token, _signed_in_resourse = nil)
    data = access_token.info
    user = User.where(provider: access_token.provider, uid: access_token.uid).first

    if user
      return user
    else
      registered_user = User.where(email: access_token.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          name: data['name'],
          provider: access_token.provider,
          email: data['email'],
          uid: access_token.uid,
          image: data['image'],
          password: Devise.friendly_token[0, 20]
        )
      end
    end
  end

  def self.find_for_facebook_oauth(access_token, _signed_in_resourse = nil)
    data = access_token.info
    user = User.where(provider: access_token.provider, uid: access_token.uid).first

    if user
      return user
    else
      registered_user = User.where(email: data.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          name: access_token.extra.raw_info.name,
          provider: access_token.provider,
          email: data.email,
          uid: access_token.uid,
          image: data.image,
          password: Devise.friendly_token[0, 20]
        )
      end
    end
  end

  def self.find_for_github_oauth(access_token, _signed_in_resourse = nil)
    data = access_token['info']
    user = User.where(provider: access_token['provider'], uid: access_token['uid']).first

    if user
      return user
    else
      registered_user = User.where(email: data['email']).first
      if registered_user
        return registered_user
      else

        name = if data['name'].nil?
                 data['nickname']
               else
                 data['name']
               end

        user = User.create(
          name: name,
          provider: access_token['provider'],
          email: data['email'],
          uid: access_token['uid'],
          image: data['image'],
          password: Devise.friendly_token[0, 20]
        )
      end
    end
  end
end
