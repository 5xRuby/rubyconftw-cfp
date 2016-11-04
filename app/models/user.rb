class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  devise :database_authenticatable
  devise :omniauthable, :omniauth_providers => [:github,:twitter]

  has_many :papers
  has_many :reviews
  has_many :activities, through: :user_activity_relationships
  has_many :comments
  validates_presence_of :name

  def self.as_yaml(options = {})
    result = all.map { |item| item.as_json(options) }
    result = {"#{model_name.plural}" => result} if options[:include_root]
    result.to_yaml
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      user.email = auth.info.email
      user.name = auth.info.name   # assuming the user model has a name
      user.github_username = auth.info.nickname if user.provider == "github" # for github
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

  def self.update_github_username
    User.where(provider: "github", github_username: nil).each {|user| user.update_github_username}
  end

  def update_github_username
    url = "https://api.github.com/user/#{self.uid}"
    user_data = JSON.parse(open(url).read)
    update(github_username: user_data["login"])
  rescue
    logger.error "Cannot update github username for uid = #{self.id}"
  end

  def github_link_text
    self.github_username.nil? ? "(Not yet updated)" : self.github_username
  end

  def github_url
    self.github_username.present? ? "https://github.com/#{self.github_username}" : ""
  end

  def full_name
    if firstname.present? && lastname.present?
      "#{firstname} #{lastname}"
    else
      name
    end
  end

  def twitter_url
    if twitter.present?
      if twitter =~ /https?:\/\/twitter\.com/i
        twitter
      else
        "https://twitter.com/#{twitter.gsub("@","")}"
      end
    else
      ""
    end
  end

  def title_with_company
    @title_with_company ||= [self.title, self.company].select{|x| x.present?}.join(", ")
  end

  def as_json(options = {})
    hostname = options[:hostname]
    result_hash = {
      name: full_name,
      avatar: full_avatar_url(hostname),
      title: title_with_company,
      urlGithub: github_url,
      urltwitter: twitter_url,
    }
    result_hash.stringify_keys!
    # remove unused while space characters
    result_hash.each do |key, value|
      result_hash[key] = value.gsub(/(\s*)\n(\s*)/,"\n") if value
    end
  end

  def full_avatar_url(hostname = "")
    if photo.present?
      "//#{hostname}#{photo.url}"
    else
      "//avatars.githubusercontent.com/u/#{uid}?v=3"
    end
  end
end
