class RemoveUserPaperRelationships < ActiveRecord::Migration
  def up
    drop_table :user_paper_relationships
  end

  def down
    create_table :user_paper_relationships do |t|
      t.integer  "user_id"
      t.integer  "paper_id"
      t.boolean  "is_author"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end

end
