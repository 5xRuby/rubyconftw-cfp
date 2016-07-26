class RenamePapersStatusToState < ActiveRecord::Migration
  def change
    change_table :papers do |t|
      t.rename :status, :state
    end
  end
end
