# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  project_id :integer
#  user_id    :integer
#  comment    :text
#  created_at :datetime         not null
#  star       :integer
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reviews_on_project_id  (project_id)
#  index_reviews_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_64798be025  (project_id => projects.id)
#  fk_rails_74a66bd6c5  (user_id => users.id)
#

class Review < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
end
