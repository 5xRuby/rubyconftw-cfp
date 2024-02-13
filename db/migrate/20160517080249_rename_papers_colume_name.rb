class RenamePapersColumeName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :papers,:Title,:title
  	rename_column :papers,:Abstract,:abstract
  	rename_column :papers,:Outline,:outline
  	rename_column :papers,:Status,:status

  end
end

