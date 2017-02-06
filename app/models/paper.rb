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

  validates :title, word: { in: Settings.paper.title.min..Settings.paper.title.max} if Settings.paper.title.limit_word
  validates :abstract, word: { in: Settings.paper.abstract.min..Settings.paper.abstract.max } if Settings.paper.abstract.limit_word
  validates  :speaker_bio, word: { in: Settings.paper.bio.min..Settings.paper.bio.max } if Settings.paper.bio.limit_word
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

  acts_as_taggable_on :tags

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

  XLS_TITLES = %w{Title Tags State Name Github Duration}

  def as_xls_row_arr
    [self.title, self.tag_list.join(","), self.state, self.state, self.user.github_username, self.answer_of_custom_fields["1"]]
  end

  def self.as_axlsx
    pkg = Axlsx::Package.new
    pkg.workbook.add_worksheet(:name => self.first.activity.name ) do |sheet|
      sheet.add_row XLS_TITLES
      all.each do |paper|
        sheet.add_row paper.as_xls_row_arr
      end
    end
    pkg
  end

  def self.as_xls
    wbk = Spreadsheet::Workbook.new
    wsh = wbk.create_worksheet name: self.first.activity.name
    wsh.insert_row(0, XLS_TITLES)
    all.each_with_index do |paper, idx|
      wsh.insert_row(idx + 1, paper.as_xls_row_arr)
    end
    wbk
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
