class RenamePapersStatusToState < ActiveRecord::Migration[5.2]
  def change
    change_table :papers do |t|
      t.rename :status, :state
    end
  end
end
