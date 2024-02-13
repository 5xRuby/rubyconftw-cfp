class AddActivityIdToPaper < ActiveRecord::Migration[5.2]
  def change
    add_reference :papers, :activity, index: true, foreign_key: true
  end
end
