class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  devise :database_authenticatable
  devise :omniauthable, :omniauth_providers => [:github,:twitter]
  has_many :papers
  has_many :reviews
  has_many :activities, through: :user_activity_relationships
  validates_presence_of :name

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      user.email = auth.info.email
      user.name = auth.info.name   # assuming the user model has a name
      user.photo = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      elsif data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
