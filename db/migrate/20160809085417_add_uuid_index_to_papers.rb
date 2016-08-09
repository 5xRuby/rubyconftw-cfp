class AddUuidIndexToPapers < ActiveRecord::Migration[5.0]
  def change
    add_index :papers, :uuid
  end
end
