# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subscriptions_on_project_id              (project_id)
#  index_subscriptions_on_project_id_and_user_id  (project_id,user_id) UNIQUE
#  index_subscriptions_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_933bdff476  (user_id => users.id)
#  fk_rails_d0c8bda804  (project_id => projects.id)
#

class Subscription < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
end
