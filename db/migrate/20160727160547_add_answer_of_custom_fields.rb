class AddAnswerOfCustomFields < ActiveRecord::Migration
  def change
    change_table :papers do |t|
      t.jsonb :answer_of_custom_fields, default: {}
    end
  end
end
