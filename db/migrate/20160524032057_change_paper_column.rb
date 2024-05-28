class ChangePaperColumn < ActiveRecord::Migration[5.2]
  def up
  	change_column(:papers,:abstract,:text)
  	change_column(:papers,:outline,:text)
  end

  def down
  	change_column(:papers,:abstract, :string)
  	change_column(:papers,:outline, :string)
  end
end
