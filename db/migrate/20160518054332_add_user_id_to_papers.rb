class AddUserIdToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :user_id, :integer
  end
end
