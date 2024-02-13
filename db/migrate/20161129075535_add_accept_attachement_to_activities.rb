class AddAcceptAttachementToActivities < ActiveRecord::Migration[5.2][5.0]
  def change
    add_column :activities, :accept_attachement, :boolean
  end
end
