class Paper < ApplicationRecord
  include AASM
  ALL_STATUS = %w{submitted reviewed accepted rejected withdrawn}
  ALL_LANGUAGES = %w{Chinese English}

  attr_writer :custom_field_errors

	mount_uploader :speaker_avatar, PictureUploader

  validates_length_of :title, in: 2..60
  validates_length_of :abstract, :speaker_bio, in: 10..600
	validates_presence_of :title
	validates_presence_of :abstract
	validates_presence_of :outline
  validate :validate_custom_fields
  validate :validate_proposal_expires, on: :create
  validates_presence_of :speaker_bio, :language

  enum state: Hash[ALL_STATUS.map{|x| [x,x]}]
  enum language: Hash[ALL_LANGUAGES.map{|x| [x,x]}]

	belongs_to :activity, counter_cache: true
	belongs_to :user

  has_many :reviews
  has_many :comments
  has_many :tags

  aasm(column: :state) do
    state :submitted , initial: true
    state *(ALL_STATUS[1..-1].map(&:to_sym))
    event :view do
      transitions from: :submitted , to: :reviewed
    end
    event :accept do
      transitions from: :reviewed, to: :accepted
    end
    event :reject do
      transitions from: :reviewed, to: :rejected
    end
    event :withdraw do
      transitions to: :withdrawn
    end
  end

  after_create :notify_user

  default_value_for :speaker_name do |paper|
    paper.user.try(:name)
  end

  default_value_for :uuid do
    SecureRandom.hex(4)
  end

  def to_param
    uuid
  end

  def custom_fields
    activity.custom_fields.map do |field|
      {
        name: field.name,
        value: answer_of_custom_fields[field.id.to_s] || nil
      }
    end
  end

  def custom_field_errors
    @custom_field_errors ||= {}
  end

  def reviewed_by?(user)
    reviews.pluck(:user_id).include?(user.id)
  end

  private

  def notify_user
    PapersMailer.notification_after_create(self.id).deliver_now!
  end

  def validate_custom_fields
    return if activity.nil?
    self.activity.custom_fields.each do |cf|
      val = self.answer_of_custom_fields[cf.id.to_s]
      if cf.required && val.blank?
        custom_field_errors[cf.id.to_s] = I18n.translate("errors.messages.blank")
      end
    end
  end

  def validate_proposal_expires
    return if activity.nil?
    unless activity.open?
      errors[:base] << I18n.translate("flash.cfp_not_open_yet")
    end
  end

end
