class CreateUserActivityRelationships < ActiveRecord::Migration
  def change
    create_table :user_activity_relationships do |t|
      t.integer :user_id
      t.integer :activity_id
      t.boolean :isReviewer

      t.timestamps null: false
    end
  end
end
