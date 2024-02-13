class AddSpeakerBioToPapers < ActiveRecord::Migration[5.2][5.0]
  def change
    add_column :papers, :speaker_bio, :text
  end
end
