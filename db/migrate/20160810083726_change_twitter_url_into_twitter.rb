class ChangeTwitterUrlIntoTwitter < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :twitter_url, :twitter
  end
end
