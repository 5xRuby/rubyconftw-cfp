class AddStateToReviews < ActiveRecord::Migration[5.2][5.0]
  def change
    add_column :reviews, :state, :string
  end
end
