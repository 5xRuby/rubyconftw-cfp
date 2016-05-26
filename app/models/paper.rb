class Paper < ActiveRecord::Base

	before_create :update_status
	mount_uploader:file_name,PictureUploader
	validates_presence_of:title
	validates_presence_of:abstract
	validates_presence_of:outline
	validates_presence_of:file_name
	
	belongs_to :activity, counter_cache: true
	belongs_to :user
  
  	has_many :user_paper_relationships, dependent: :destroy
  	has_many :users, through: :user_paper_relationships 

  	private 
  		def update_status 
  			self.status = "新稿件"
		end

end
