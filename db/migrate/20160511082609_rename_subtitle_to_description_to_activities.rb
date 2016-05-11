class RenameSubtitleToDescriptionToActivities < ActiveRecord::Migration
  def change
  	rename_column :activities, :subtitle, :description
  end
end
