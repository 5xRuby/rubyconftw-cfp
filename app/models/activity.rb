class Activity < ActiveRecord::Base
	has_many :papers, dependent: :destroy
	mount_uploader :logo, LogoUploader
end
