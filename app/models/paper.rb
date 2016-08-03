class Paper < ActiveRecord::Base
  include AASM
  ALL_STATUS = %w{submitted reviewed accepted rejected}

	mount_uploader :speaker_avatar, PictureUploader
	validates_presence_of :title
	validates_presence_of :abstract
	validates_presence_of :outline

  enum state: Hash[ALL_STATUS.map{|x| [x,x]}]

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
  end

	belongs_to :activity, counter_cache: true
	belongs_to :user
  after_create :notify_user

  default_value_for :speaker_name do |paper|
    paper.user.try(:name)
  end

  private

  def notify_user
    PapersMailer.notification_after_create(self.id).deliver_now!
  end

end
