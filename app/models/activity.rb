class Activity < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :papers, dependent: :destroy
  has_many :user_activity_relationships, dependent: :destroy
  has_many :users, through: :user_activity_relationships
  has_many :custom_fields, lambda {order("sort_order")}, dependent: :destroy
  has_many :reviews, through: :papers
  has_many :speakers, -> { where(papers: { state: :accepted }).uniq }, through: :papers, source: :user
  has_many :custom_field_answers
  has_many :tags, -> { uniq }, through: :papers
  has_many :accepted_paper_tags, -> { where(papers: {state: :accepted}).uniq }, through: :papers, source: :tags
  accepts_nested_attributes_for :custom_fields, allow_destroy: true
  mount_uploader :logo, LogoUploader
  scope :recent, -> { order(created_at: :desc) }

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :open_at
  validates_presence_of :close_at
  validates_presence_of :permalink
  validate :validate_end_date_after_start_date
  validate :validate_close_time_after_open_time

  def to_param
    permalink
  end

  def status
    open? ? "open" : "closed"
  end

  def review_by(user)
    reviews.where(user: user)
  end

  def unreview_by(user)
    papers.where.not(id: review_by(user).pluck(:paper_id))
          .state([:submitted, :reviewed])
  end

  def open?(time = Time.now)
    time >= open_at && time <= close_at
  end

  def validate_end_date_after_start_date
    return if self.end_date.blank? || self.start_date.blank?
    unless self.end_date >= self.start_date
      errors[:end_date] << "必須晚於起始時間"
    end
  end

  def validate_close_time_after_open_time
    return if self.close_at.blank? || self.open_at.blank?
    unless self.close_at >= self.open_at
      errors[:close_at] << "必須晚於起始時間"
    end
  end

  def self.initialize_permalink
    self.where("permalink IS NULL").each do |activity|
      activity.update permalink: activity.name.downcase.gsub(" ", "-")
    end
  end
end
