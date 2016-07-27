class Paper < ActiveRecord::Base
  include AASM
  ALL_STATUS = %w{submitted reviewed accepted rejected}

	mount_uploader :speaker_avatar, PictureUploader
	validates_presence_of :title
	validates_presence_of :abstract
	validates_presence_of :outline
	#validates_presence_of :speaker_avatar

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

  has_many :user_paper_relationships, dependent: :destroy
  has_many :users, through: :user_paper_relationships

  after_create :send_notification_to_user

  private

  def send_notification_to_user
    PapersMailer.sent_cfp_email.deliver_now!
  end

end
