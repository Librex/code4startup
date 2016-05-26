# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string
#  note       :text
#  video      :string
#  header     :boolean          default(FALSE), not null
#  tag        :string
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
