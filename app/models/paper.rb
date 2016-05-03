class Paper < ActiveRecord::Base
	mount_uploader:FileName,PictureUploader
	validates_presence_of:Title
	validates_presence_of:Abstract
	validates_presence_of:Outline
	validates_presence_of:FileName
	validates_presence_of:Status
	
end
