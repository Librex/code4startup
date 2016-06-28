# == Schema Information
#
# Table name: plans
#
#  id           :integer          not null, primary key
#  name         :string
#  amount       :integer
#  complete_flg :boolean
#  student_flg  :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Plan < ActiveRecord::Base
end
