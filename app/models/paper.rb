class Paper < ActiveRecord::Base
	mount_uploader:fileName,PictureUploader
	validates_presence_of:title
	validates_presence_of:abstract
	validates_presence_of:outline
	validates_presence_of:fileName
	validates_presence_of:status
	
	belongs_to :activity, counter_cache: true
end
