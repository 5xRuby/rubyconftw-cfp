class ChangeIsReviewerColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:user_activity_relationships, :isReviewer, :is_reviewer) 
  end
end
