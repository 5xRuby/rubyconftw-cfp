class ChangeActivitiesEventDataToTime < ActiveRecord::Migration[5.0]
  def up
    change_table :activities do |t|
      t.rename :event_start_date, :open_at
      t.rename :event_end_date, :close_at
      t.change :open_at, :datetime
      t.change :close_at, :datetime
    end
  end

  def down
    change_table :activities do |t|
      t.rename :open_at, :event_start_date
      t.rename :close_at, :event_end_date
      t.change :event_start_date, :date
      t.change :event_end_date, :date
    end
  end
end
