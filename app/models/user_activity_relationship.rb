class UserActivityRelationship < ApplicationRecord
    belongs_to :user
    belongs_to :activity
    validates_presence_of :user_id
end
