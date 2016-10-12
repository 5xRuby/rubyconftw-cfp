class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :github_username, :string
  end
end
