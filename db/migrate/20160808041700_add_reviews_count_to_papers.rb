class AddReviewsCountToPapers < ActiveRecord::Migration[5.2][5.0]
  def change
    add_column :papers, :reviews_count, :integer, default: 0
  end
end
