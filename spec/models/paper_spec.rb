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

  context "state" do
    it "should able to change to reviewed from submmitted" do
      paper = Paper.new
      expect(paper).to transition_from(:submitted).to(:reviewed).on_event(:view)
    end

    it "should able to change to accepted or rejected from reviewed" do
      paper = Paper.new(state: :reviewed)
      expect(paper).to transition_from(:reviewed).to(:accepted).on_event(:accept)
      expect(paper).to transition_from(:reviewed).to(:rejected).on_event(:reject)
      expect(paper).to_not allow_transition_to(:submitted)
    end

    it "should able to change to withdrawn at any time" do
      paper = Paper.new
      expect(paper).to transition_from(:submitted).to(:withdrawn).on_event(:withdraw)
      expect(paper).to transition_from(:reviewed).to(:withdrawn).on_event(:withdraw)
      expect(paper).to transition_from(:accepted).to(:withdrawn).on_event(:withdraw)
      expect(paper).to transition_from(:rejected).to(:withdrawn).on_event(:withdraw)
    end
  end

  it "should have default speaker name from user name" do
    user = User.new(name: "Speaker")
    paper = Paper.new(user: user)
    expect(paper.speaker_name).to eq(user.name)
  end

  it "should generate default uuid" do
    paper = Paper.new
    expect(paper.uuid).not_to be_nil
  end

  it "should have param use uuid" do
    paper = Paper.new
    expect(paper.to_param).to eq(paper.uuid)
  end

  it "should able to check user already reviewed it or not" do
    user = FactoryGirl.create(:user)
    paper = FactoryGirl.create(:paper_with_review, review_by: user)
    expect(paper.reviewed_by?(user)).to be true
  end

  it "should able to read custom field" do
    activity = FactoryGirl.create(:activity_with_custom_field, field_count: 5)
    paper = FactoryGirl.create(:paper, activity: activity)
    expect(paper.custom_fields.size).to eq(5)
    expect(paper.custom_fields.first).to have_key(:name)
    expect(paper.custom_fields.first).to have_key(:value)
    expect(paper.custom_fields.first[:name]).to eq(activity.custom_fields.first.name)
  end
end
