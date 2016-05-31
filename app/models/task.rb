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
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_slug        (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_02e851e3b7  (project_id => projects.id)
#

class Task < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: [:slugged, :finders]
	
  belongs_to :project
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :video, presence: true
  validates :tag, presence: true
  validates :project, presence: true
  
  def next
  	project.tasks.where("tag > ? AND header = ?", tag, false).order(:tag).first
  end

  def prev
  	project.tasks.where("tag < ? AND header = ?", tag, false).order(:tag).last
  end
  
end
