class ChangePaperColumn < ActiveRecord::Migration
  def up
  	change_column(:papers,:abstract,:text)
  	change_column(:papers,:outline,:text)
  end

  def down
  	change_column(:papers,:abstract, :string)
  	change_column(:papers,:outline, :string)
  end
end
