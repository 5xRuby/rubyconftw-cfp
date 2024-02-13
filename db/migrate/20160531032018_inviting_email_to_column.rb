class InvitingEmailToColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :papers, :inviting_email, :string
  end
end
