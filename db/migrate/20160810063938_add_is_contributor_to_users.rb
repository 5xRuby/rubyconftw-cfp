class AddIsContributorToUsers < ActiveRecord::Migration[5.2][5.0]
  def change
    add_column :users, :is_contributor, :boolean, default: false
    add_index :users, :is_contributor
  end
end
