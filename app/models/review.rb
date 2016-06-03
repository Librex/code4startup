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

class Review < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
end
