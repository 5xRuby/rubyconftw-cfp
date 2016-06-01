class Activity < ActiveRecord::Base
	has_many :categories, dependent: :destroy
	has_many :papers, dependent: :destroy
	has_many :user_activity_relationships, dependent: :destroy
    has_many :users, through: :user_activity_relationships
	mount_uploader :logo, LogoUploader
end
