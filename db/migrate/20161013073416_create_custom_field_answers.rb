class CreateCustomFieldAnswers < ActiveRecord::Migration
  def change
    create_view :custom_field_answers
  end
end
