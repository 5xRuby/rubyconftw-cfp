class AddDescriptionToCustomFields < ActiveRecord::Migration
  def change
    add_column :custom_fields, :description, :text
  end
end
