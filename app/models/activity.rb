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

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :open_at
  validates_presence_of :close_at
  validate :validate_end_date_after_start_date
  validate :validate_close_time_after_open_time


  def status
    open? ? "open" : "closed"
  end

  def review_by(user)
    reviews.where(user: user)
  end

  def open?(time = Time.now)
    time >= open_at && time <= close_at
  end

  def validate_date_before_now
    return if self.start_date.blank?
    unless self.start_date > 1.day.ago
      errors[:start_date] << "活動起始時間必須晚於現在的時間"
    end
  end

  def validate_end_date_after_start_date
    return if self.end_date.blank? || self.start_date.blank?
    unless self.end_date >= self.start_date
      errors[:end_date] << "活動結束時間必須晚於起始時間"
    end
  end

  def validate_open_time_before_now
    return if self.open_at.blank?
    unless self.open_at >= 5.minute.ago
      errors[:open_at] << "投稿起始時間必須晚於現在的時間"
    end
  end

  def validate_close_time_after_open_time
    return if self.close_at.blank? || self.open_at.blank?
    unless self.close_at >= self.open_at
      errors[:close_at] << "投稿結束時間必須起始時間"
    end
  end
end
