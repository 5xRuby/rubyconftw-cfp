class AddPapersCountToActivity < ActiveRecord::Migration
  def change  
    add_column :activities, :papers_count, :integer, default: 0
  end
end
