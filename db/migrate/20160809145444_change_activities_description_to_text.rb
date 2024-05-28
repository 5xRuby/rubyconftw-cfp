class ChangeActivitiesDescriptionToText < ActiveRecord::Migration[5.2][5.0]
  def up
    change_column :activities, :description, :text
  end

  def down
    change_column :activities, :description, :string
  end

end
