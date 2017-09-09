require 'rails_helper'

RSpec.describe "Admin::Activities", type: :request do
  let(:admin) { FactoryGirl.create(:user, :admin) }

  before(:each) { login_as admin }

  describe "GET /admin/activities" do
    before(:each) do
      @activities = FactoryGirl.create_list(:activity, 5)
      visit admin_activities_url
    end

    it "cannot viewed by non-admin user" do
      user = FactoryGirl.create(:user)
      login_as user
      visit admin_activities_url
      expect(page).to have_content("Permission Denied")
    end

    it "display all activities" do
      @activities.each do |activity|
        expect(page).to have_content(activity.name)
      end
    end
  end

  describe "GET /admin/acivities/:id" do

    before(:each) do
      @activity = FactoryGirl.create(:activity)
      visit admin_activity_url(@activity)
    end

    it "shows activity details" do
      expect(page).to have_content(@activity.name)
      expect(page).to have_content(@activity.description)
    end
  end

  describe "POST /admin/activities" do
    before(:each) { visit new_admin_activity_url }
    it "creates a new activity" do
      within ".new_activity" do
        fill_in "Name", with: "RubyConfTW"
        fill_in "Description", with: "RubyConfTW is a conference of ruby in Taiwan"
        click_button "Save"
      end

      expect(page).to have_content("RubyConfTW")
    end

    it "show errors when not fill required fields" do
      within ".new_activity" do
        click_button "Save"
      end

      expect(page).to have_css(".has-error")
    end

    it "adds custom field"
  end

  describe "PUT /admin/activities/:id" do
    before(:each) do
      @activity = FactoryGirl.create(:activity)
      visit edit_admin_activity_url(@activity)
    end

    it "update a activity" do
      within ".edit_activity" do
        fill_in "Name", with: "RubyConfTW"
        fill_in "Description", with: "RubyConfTW's description"
        click_button "Save"
      end

      expect(page).to have_content("RubyConfTW")
    end

    it "didn't update activity when not fill required fields" do
      within ".edit_activity" do
        fill_in "Name", with: ""
        click_button "Save"
      end

      expect(page).to have_css(".has-error")
    end
  end

  describe "DELETE /admin/activities/:id" do
    before(:each) do
      @activity = FactoryGirl.create(:activity)
      visit admin_activities_url
    end

    it "delete a activity" do
      within "#activity_#{@activity.id}" do
        find(:css, "a[title='Remove']").click
      end
      expect(page).not_to have_content(@activity.name)
    end
  end

  describe "POST /admin/activities/:id/mails" do
    before(:each) do
      @activity = FactoryGirl.create(:activity_with_papers)
      @papers = @activity.papers

      visit admin_activity_papers_url(@activity)
    end

    it "sends mail to selected papers owner" do
      within "#paper_#{@papers.first.id}" do
        check "notification_ids_#{@papers.first.user.id}"
      end

      within ".notification" do
        fill_in "notification[subject]", with: "Notification Mail"
        fill_in "notification[content]", with: "Some message from CFP system"
        click_button "Send"
      end

      expect(page).to have_content("Mail already sent")
    end

    it "didn't sends mail to selected papers owner when not fill required fields" do
      within ".notification" do
        click_button "Send"
      end

      expect(page).to have_css(".has-error")
    end
  end

end
