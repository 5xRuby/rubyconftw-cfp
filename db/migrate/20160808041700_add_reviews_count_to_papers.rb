class AddReviewsCountToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :reviews_count, :integer
  end
end
