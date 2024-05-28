class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.string :Title
      t.string :Abstract
      t.string :Outline
      t.string :FileName
      t.string :Status

      t.timestamps null: false
    end
  end
end
