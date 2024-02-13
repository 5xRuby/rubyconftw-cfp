class AddDescriptionToCustomFields < ActiveRecord::Migration[5.2]
  def change
    add_column :custom_fields, :description, :text
  end
end
