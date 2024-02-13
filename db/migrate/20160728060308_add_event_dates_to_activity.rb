class AddEventDatesToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :event_start_date, :date
    add_column :activities, :event_end_date, :date
  end
end
