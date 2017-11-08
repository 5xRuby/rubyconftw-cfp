class ChangeReviewedDatatypeOnReview < ActiveRecord::Migration[5.0]
  def change
    change_column :reviews, :reviewed, :string, default: :pending
  end
end
