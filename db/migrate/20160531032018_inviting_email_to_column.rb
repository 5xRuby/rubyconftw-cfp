class InvitingEmailToColumn < ActiveRecord::Migration
  def change
  	add_column :papers, :inviting_email, :string
  end
end
