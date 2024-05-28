class AddUserIdToPapers < ActiveRecord::Migration[5.2]
  def change
    add_column :papers, :user_id, :integer
  end
end
