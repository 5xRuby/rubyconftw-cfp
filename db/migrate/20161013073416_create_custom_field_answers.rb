class CreateCustomFieldAnswers < ActiveRecord::Migration[5.2]
  def change
    create_view :custom_field_answers
  end
end
