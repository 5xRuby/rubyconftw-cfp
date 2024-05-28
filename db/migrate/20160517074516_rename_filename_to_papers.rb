class RenameFilenameToPapers < ActiveRecord::Migration[5.2]
  def change
  	rename_column :papers, :FileName, :file_name
  end
end
