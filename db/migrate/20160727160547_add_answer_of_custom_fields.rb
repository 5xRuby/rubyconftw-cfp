class AddAnswerOfCustomFields < ActiveRecord::Migration[5.2]
  def change
    change_table :papers do |t|
      t.jsonb :answer_of_custom_fields, default: {}
    end
  end
end
