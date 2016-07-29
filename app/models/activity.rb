class Activity < ActiveRecord::Base
	has_many :categories, dependent: :destroy
	has_many :papers, dependent: :destroy
	has_many :user_activity_relationships, dependent: :destroy
  has_many :users, through: :user_activity_relationships
  has_many :custom_fields
  accepts_nested_attributes_for :custom_fields
	mount_uploader :logo, LogoUploader


  def status
    self.end_date > Time.now ? "open" : "closed"
  end
  def open?
    activity.end_date > Time.now
  end
end
