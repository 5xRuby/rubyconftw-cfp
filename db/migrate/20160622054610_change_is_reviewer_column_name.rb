class ChangeIsReviewerColumnName < ActiveRecord::Migration
  def change
    rename_column(:user_activity_relationships, :isReviewer, :is_reviewer) 
  end
end
