require 'rails_helper'

RSpec.describe "Admin::Activities", type: :request do
  let(:admin) { FactoryGirl.create(:user, :admin) }

  describe "GET /admin/activities" do
    it "cannot viewed by non-admin user" do
      user = FactoryGirl.create(:user)
      login_as user
      visit admin_activities_url
      expect(page).to have_content("Permission Denied")
    end

    it "display all activities" do
      activities = FactoryGirl.create_list(:activity, 5)

      login_as admin
      visit admin_activities_url
      activities.each do |activity|
        expect(page).to have_content(activity.name)
      end
    end
  end

  describe "GET /admin/acivities/:id" do
    let(:activity) { FactoryGirl.create(:activity) }
    it "shows activity details" do
      login_as admin
      visit admin_activity_url(activity)
      expect(page).to have_content(activity.name)
      expect(page).to have_content(activity.description)
    end
  end


  describe "POST /admin/activities" do
    it "creates a new activity" do
      login_as admin
      visit new_admin_activity_url

      within ".new_activity" do
        fill_in "Name", with: "RubyConfTW"
        fill_in "Description", with: "RubyConfTW is a conference of ruby in Taiwan"
        click_button "Save"
      end

      expect(page).to have_content("RubyConfTW")
    end

    it "show errors when not fill required fields" do
      login_as admin
      visit new_admin_activity_url

      within ".new_activity" do
        click_button "Save"
      end

      expect(page).to have_css(".has-error")
    end
  end

  describe "PUT /admin/activities/:id" do
    let(:activity) { FactoryGirl.create(:activity) }
    it "update a activity" do
      login_as admin
      visit edit_admin_activity_url(activity)

      within ".edit_activity" do
        fill_in "Name", with: "RubyConfTW"
        fill_in "Description", with: "RubyConfTW's description"
        click_button "Save"
      end

      expect(page).to have_content("RubyConfTW")
    end

    it "adds custom field"
  end

end
