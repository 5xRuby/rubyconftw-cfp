class AddCollectionToCustomFields < ActiveRecord::Migration[5.2][5.0]
  def change
    add_column :custom_fields, :collection, :string, array: true, default: []
  end
end
