class Paper < ActiveRecord::Base
	mount_uploader :file_name, PictureUploader
	validates_presence_of:Title
	validates_presence_of:Abstract
	validates_presence_of:Outline
	validates_presence_of :file_name
	validates_presence_of:Status
	
	belongs_to :activity, counter_cache: true
end
