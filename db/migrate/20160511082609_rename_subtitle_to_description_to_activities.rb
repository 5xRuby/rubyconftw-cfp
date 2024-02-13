class RenameSubtitleToDescriptionToActivities < ActiveRecord::Migration[5.2]
  def change
  	rename_column :activities, :subtitle, :description
  end
end
