require 'rails_helper'

RSpec.describe Activity, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:open_at) }
  it { should validate_presence_of(:close_at) }

  it "should validate end date after start date" do
    @activity = Activity.new
    @activity.start_date = 1.day.ago
    @activity.end_date = 2.day.ago
    @activity.valid?
    expect(@activity.errors.full_messages).to include("End date 必須晚於起始時間")
  end

  it "should validate close time after start time" do
    @activity = Activity.new
    @activity.open_at = 1.hour.ago
    @activity.close_at = 2.hours.ago
    @activity.valid?
    expect(@activity.errors.full_messages).to include("Close at 必須晚於起始時間")
  end

  let(:opened_activity) { Activity.new(open_at: 1.hour.ago, close_at: 1.hour.from_now) }
  let(:closed_activity) { Activity.new(open_at: 2.hour.ago, close_at: 1.hour.ago) }

  it "should open when current time between open_at and end_at" do
    expect(opened_activity.open?).to be true
  end

  it "should return open status when activity is opened" do
    expect(opened_activity.status).to eq("open")
  end

  it "should return closed status when activity is closed" do
    expect(closed_activity.status).to eq("closed")
  end

  context "papers review state" do
    let(:user) { FactoryGirl.create(:user) }
    let(:activity) { FactoryGirl.create(:activity) }

    before(:each) do
        @unreview_papers = FactoryGirl.create_list(:paper, 5, activity: activity)
        @reviewed_papers = FactoryGirl.create_list(:paper_with_review, 5, activity: activity, review_by: user)
        @withdrawn_paper = FactoryGirl.create(:paper, :withdrawn, activity: activity)
        @unreview_accepted_paper = FactoryGirl.create(:paper, :accepted, activity: activity)
        @unreview_rejected_paper = FactoryGirl.create(:paper, :rejected, activity: activity)
    end

    it "should able to find propals review by specify user" do
      expect(activity.review_by(user).size).to eq(@reviewed_papers.size)
    end

    it "should able to find unreview papers by specify user" do
      expect(activity.unreview_by(user).size).to eq(@unreview_papers.size)
    end

    context "public display" do
      it "ignore withdraw papaer" do
        opended_papers = @unreview_papers.size +
                         @reviewed_papers.size +
                         1                     + # Unreview Accepted Paper
                         1                       # Unreview Rejected Paper

        expect(activity.papers.opened.size).to eq(opended_papers)
      end
    end
  end
end
