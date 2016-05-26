class User < ActiveRecord::Base
  devise :database_authenticatable
  devise :omniauthable, :omniauth_providers => [:github,:twitter]
  has_many :user_activity_relationships, dependent: :destroy
  has_many :activities, through: :user_activity_relationships
  has_many :user_paper_relationships, dependent: :destroy
  has_many :papers, through: :user_paper_relationships  
  before_update :profile_validation

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
  def profile_validation
    validates_presence_of :name
    validates_presence_of :firstname
    validates_presence_of :lastname
    validates_presence_of :phone
  end
  
  
  
  
end
