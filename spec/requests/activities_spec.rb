require 'rails_helper'

RSpec.describe "Activities", type: :request do
  describe "GET /activities" do
    it "displays the activities list" do
      activities = FactoryGirl.create_list(:activity, 2)

      visit activities_url
      expect(page).to have_content(activities.first.name)
      expect(page).to have_content(activities.second.name)
    end
  end

  describe "GET /activities/:id" do
    it "displays activities details" do
      activity = FactoryGirl.create(:activity)

      visit activity_url(activity)
      expect(page).to have_content(activity.name)
      expect(page).to have_content(activity.description)
      expect(page).to have_content(activity.term)
    end
  end
end
