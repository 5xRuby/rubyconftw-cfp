class AddIndexOnOAuth < ActiveRecord::Migration[5.2][5.0]
  def change
    add_index :users, [:uid, :provider]
    add_index :users, :uid
  end
end
