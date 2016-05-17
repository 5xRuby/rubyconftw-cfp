class RenameFilenameToPapers < ActiveRecord::Migration
  def change
  	rename_column :papers, :FileName, :file_name
  end
end
