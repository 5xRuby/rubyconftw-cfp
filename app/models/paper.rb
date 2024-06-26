class Paper < ApplicationRecord
  include AASM
  ALL_STATUS = %w{submitted reviewed accepted rejected withdrawn}
  ALL_LANGUAGES = %w{Chinese English}
  StateClass = {
    "submitted" => 'label-info',
    "reviewed" => 'label-primary',
    "accepted" => 'label-success',
    "rejected" => 'label-warning',
    "withdraw" => 'label-danger'
  }

  attr_writer :custom_field_errors

	mount_uploader :speaker_avatar, PictureUploader
  mount_uploader :attachement, AttachementUploader

  %i[abstract speaker_bio title].each do |attr|
    define_method([attr, 'words'].join('_')) { send(attr).to_s.scan(/\w+/) }
  end

  validates :title_words, length: { in: Settings.paper.title.min..Settings.paper.title.max }
  validates :abstract_words, length: { in: Settings.paper.abstract.min..Settings.paper.abstract.max }
  validates :speaker_bio_words, length: { in: Settings.paper.bio.min..Settings.paper.bio.max }

	validates_presence_of :title
	validates_presence_of :abstract
	validates_presence_of :outline
  validate :validate_custom_fields
  validate :validate_proposal_expires, on: :create
  validates_presence_of :speaker_bio, :language

  # enum state: Hash[ALL_STATUS.map{|x| [x,x]}]
  enum language: Hash[ALL_LANGUAGES.map{|x| [x,x]}]

	belongs_to :activity, counter_cache: true
	belongs_to :user

  has_many :reviews
  has_many :comments

  acts_as_taggable_on :tags

  delegate :github_url, to: :user, prefix: true
  delegate :name, to: :activity, prefix: true
  delegate :name, to: :user, prefix: :speaker

  scope :state, -> (state) { where(state: state) }
  scope :opened, -> { where.not(state: :withdrawn)}

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

  #def self.states
  #  aasm.states.map(&:name)
  #end

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

  # NOTICE: to_yaml will be override
  def self.as_yaml(options = {})
    result = all.map { |item| item.as_json(options) }
    result = {"#{model_name.plural}" => result} if options[:include_root]
    result.to_yaml
  end

  def as_json(options = {})
    hostname = options[:hostname]
    result_hash = {
      bio: self.class.markdown(speaker_bio),
      subject: title,
      summary: self.class.markdown(abstract),
      language: language,
    }
    result_hash.stringify_keys!
    # remove unused whilyye space characters, and tailing new lines
    result_hash.each do |key, value|
      result_hash[key] = value.gsub(/(\s*)\n(\s*)/,"\n").gsub(/[\n\r]*\z/,"") if value
    end
    # merge with speaker
    speaker_hash = user.as_json(options)
    speaker_hash.merge(result_hash)
  end

  def total_approve
    reviews.where(reviewed: "approve").count
  end

  def total_disapprove
    reviews.where(reviewed: "disapprove").count
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
        self.errors.add :custom_field_errors, I18n.translate("errors.messages.blank")
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
