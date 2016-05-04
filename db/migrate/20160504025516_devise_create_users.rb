class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :encrypted_password, null: false, default: ""
      t.string :email,   null: false, default: ""
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      ## Rememberable
      t.datetime :remember_created_at
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      
      #user info
      t.string :user_name
      t.string :user_firstname
      t.string :user_lastname
      t.string :user_phone
      t.string :user_title
      t.string :user_company
      t.string :user_country
      t.string :user_photo
      
      
      


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  
  end
end
