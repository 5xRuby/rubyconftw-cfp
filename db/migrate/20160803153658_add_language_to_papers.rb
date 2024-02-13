class AddLanguageToPapers < ActiveRecord::Migration[5.2][5.0]
  def change
    add_column :papers, :language, :string, limit: 32
  end
end
