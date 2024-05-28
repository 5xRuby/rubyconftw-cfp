class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :subtitle
      t.string :logo
      t.date :start_date
      t.date :end_date
      t.text :term

      t.timestamps null: false
    end
  end
end
