require 'rails_helper'

RSpec.describe Paper, type: :model do
  it { should validate_length_of(:title).is_at_least(2).is_at_most(60) }
  it { should validate_length_of(:abstract).is_at_least(10).is_at_most(600) }
  it { should validate_length_of(:speaker_bio).is_at_least(10).is_at_most(600) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:abstract) }
  it { should validate_presence_of(:outline) }
  it { should validate_presence_of(:speaker_bio) }
  it { should validate_presence_of(:language) }

  it "should validate activity is open on create" do
    activity = Activity.new
    allow(activity).to receive(:open?).and_return(false)
    paper = activity.papers.build
    paper.valid?

    expect(paper.errors.full_messages).to include("The event has not opened yet or already closed!")
  end

  it "should validate custom fields" do
    custom_field = CustomField.new(id: 1, name: 'name', required: true)
    activity = Activity.new
    allow(activity).to receive(:custom_fields).and_return([custom_field])
    allow(activity).to receive(:open?).and_return(true)
    paper = activity.papers.build
    paper.valid?

    expect(paper.activity).not_to be_nil
    expect(paper.custom_field_errors[custom_field.id.to_s]).to eq("can't be blank")
  end
end
