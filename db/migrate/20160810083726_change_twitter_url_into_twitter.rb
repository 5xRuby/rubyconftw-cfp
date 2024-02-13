class ChangeTwitterUrlIntoTwitter < ActiveRecord::Migration[5.2][5.0]
  def change
    add_column :users, :twitter, :string
  end
end
