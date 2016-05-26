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

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
