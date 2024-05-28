class RenamePapersFileNameToFile < ActiveRecord::Migration[5.2]
  def change
    change_table :papers do |t|
      t.rename :file_name, :speaker_avatar
    end
  end
end
