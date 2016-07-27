class RenamePapersFileNameToFile < ActiveRecord::Migration
  def change
    change_table :papers do |t|
      t.rename :file_name, :speaker_avatar
    end
  end
end
