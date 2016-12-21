class AddAttachementToPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :papers, :attachement, :string
  end
end
