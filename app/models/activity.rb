class Activity < ApplicationRecord
	has_many :categories, dependent: :destroy
	has_many :papers, dependent: :destroy
	has_many :user_activity_relationships, dependent: :destroy
  has_many :users, through: :user_activity_relationships
  has_many :custom_fields, lambda {order("sort_order")}, dependent: :destroy
  has_many :reviews, through: :papers
  accepts_nested_attributes_for :custom_fields, allow_destroy: true
  mount_uploader :logo, LogoUploader

  scope :recent, -> { order(created_at: :desc) }

  def status
    self.end_date > Time.now ? "open" : "closed"
  end
  def open?
    activity.end_date > Time.now
  end

  def review_by(user)
    reviews.where(user: user)
  end
end
