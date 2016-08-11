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

end
