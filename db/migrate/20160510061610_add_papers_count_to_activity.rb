class AddPapersCountToActivity < ActiveRecord::Migration[5.2]
  def change  
    add_column :activities, :papers_count, :integer, default: 0
  end
end
