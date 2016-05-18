class Paper < ActiveRecord::Base

	mount_uploader:file_name,PictureUploader
	validates_presence_of:title
	validates_presence_of:abstract
	validates_presence_of:outline
	validates_presence_of:file_name
	validates_presence_of:status
	
	belongs_to :activity, counter_cache: true
end
