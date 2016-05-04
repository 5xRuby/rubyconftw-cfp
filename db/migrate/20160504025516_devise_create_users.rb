class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :encrypted_password, null: false, default: ""
      t.string :email,   null: false, default: ""
      #user info
      t.string :name
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :title
      t.string :company
      t.string :country
      t.string :photo
      
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
  
  end
end
