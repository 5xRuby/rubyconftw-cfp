class AddIndexOnOAuth < ActiveRecord::Migration[5.0]
  def change
    add_index :users, [:uid, :provider], unique: true
    add_index :users, :uid
  end
end
