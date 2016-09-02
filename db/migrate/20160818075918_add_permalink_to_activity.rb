class AddPermalinkToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :permalink, :string
    Activity.initialize_permalink
  end
end
