class CreateUserPaperRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :user_paper_relationships do |t|
      t.integer :user_id
      t.integer :paper_id
      t.boolean :is_author

      t.timestamps null: false
    end
  end
end
