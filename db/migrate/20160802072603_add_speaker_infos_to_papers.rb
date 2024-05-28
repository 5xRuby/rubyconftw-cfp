class AddSpeakerInfosToPapers < ActiveRecord::Migration[5.2]
  def change
    change_table :papers do |t|
      t.string :speaker_name
      t.string :speaker_company_or_org
      t.string :speaker_title
      t.string :speaker_country_code, limit: 8
      t.string :speaker_site
    end
  end
end
