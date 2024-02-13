class CreateNotifiers < ActiveRecord::Migration[5.2][5.0]
  def change
    create_table :notifiers do |t|
      t.integer "activity_id"
      t.string "name"
      t.boolean "enabled", default: true 
      t.boolean "on_new_comment", default: false
      t.boolean "on_new_paper", default: false
      t.boolean "on_paper_status_changed", default: false
      t.string "service_name", default: ""
      t.jsonb "service_info", default: {}
      t.timestamps
    end
  end
end
