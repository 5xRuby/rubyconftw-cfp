class AddPitchToPapers < ActiveRecord::Migration[5.2][5.0]
  def change
    add_column :papers, :pitch, :text
  end
end
