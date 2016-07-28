class AddEventDatesToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :event_start_date, :date
    add_column :activities, :event_end_date, :date
  end
end
