class CreateReviews < ActiveRecord::Migration[5.2][5.0]
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :paper
      t.boolean :reviewed

      t.timestamps
    end
  end
end
