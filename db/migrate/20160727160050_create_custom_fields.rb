class CreateCustomFields < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_fields do |t|
      t.integer :sort_order, default: 0
      t.string :name, limit: 64
      t.integer :activity_id
      t.string :field_type, limit: 48
      t.boolean :required, default: false
      t.jsonb :options, default: {}
      t.timestamps null: false
    end
  end
end
