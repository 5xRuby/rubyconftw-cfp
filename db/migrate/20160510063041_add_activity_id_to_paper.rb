class AddActivityIdToPaper < ActiveRecord::Migration
  def change
    add_reference :papers, :activity, index: true, foreign_key: true
  end
end
