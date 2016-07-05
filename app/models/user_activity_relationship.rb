class UserActivityRelationship < ActiveRecord::Base
    belongs_to :user
    belongs_to :activity
    validates_presence_of :user_id
end
