# == Schema Information
#
# Table name: admin_users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string           not null
#  reset_password_sent_at :datetime         not null
#  remember_created_at    :datetime         not null
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime         not null
#  last_sign_in_at        :datetime         not null
#  current_sign_in_ip     :inet             not null
#  last_sign_in_ip        :inet             not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admin_users_on_email                 (email) UNIQUE
#  index_admin_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
