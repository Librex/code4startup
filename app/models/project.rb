# == Schema Information
#
# Table name: projects
#
#  id                 :integer          not null, primary key
#  name               :string
#  content            :text
#  free_flg           :integer          default(1)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string
#  deleted_at         :datetime
#
# Indexes
#
#  index_projects_on_deleted_at  (deleted_at)
#  index_projects_on_slug        (slug) UNIQUE
#

class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :tasks

  has_many :subscriptions
  has_many :users, through: :subscriptions

  has_many :reviews, dependent: :destroy

  acts_as_paranoid

  scope :free_projects, -> { projects.where(free_flg: 1) }

  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }

  has_attached_file :image,
                    styles: { medium: '680x300>', thumb: '170x75>' },
                    storage: :s3,
                    path: ':attachment/:id/:style.:extension',
                    s3_credentials: {
                      access_key_id: ENV['AWS_ACCESS_KEY'],
                      secret_access_key: ENV['SECRET_ACCESS_KEY'],
                      bucket: Settings.aws.s3.bucket,
                      s3_host_name: Settings.aws.s3.endpoint
                    }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def shortname
    name.length > 25 ? name[0..25] + '...' : name
  end

  def average_rating
    reviews.blank? ? 0 : reviews.average(:star).round(2)
  end

  def self.looking_count(current_user)
    a = current_user.subscriptions.pluck(:project_id)
    free_project = Project.find(a).select { |project| project.free_flg == 1 }
    current_user.payments.with_deleted.where(status: 0).count - current_user.subscriptions.with_deleted.count + free_project.count
  end
end
