require 'rails_helper'

RSpec.describe CustomFieldAnswer, type: :model do
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:custom_fields) { FactoryGirl.create_list(:custom_field, 5, :checkboxes, activity: activity) }
  let!(:papers) { FactoryGirl.create_list(:paper, 5, activity: activity, answer_of_custom_fields: answer_of_custom_fields) }

  let(:answer_of_custom_fields) do
    answer = {}
    custom_fields.each do |field|
      answer[field.id.to_s] = "Yes"
    end
    answer
  end

  before(:each) do
    @field = activity.custom_fields.first
    @answers = activity.custom_field_answers
  end

  it "return stats data" do
    expect(@answers.where(custom_field: @field).stats).to eq({"Yes" => papers.count})
  end

  it "return stats data with base" do
    expect(@answers.where(custom_field: @field).stats(10)).to eq({"Yes" => papers.count, "Unknown" => 10 - papers.count})
  end
end
