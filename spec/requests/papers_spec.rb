require 'rails_helper'

RSpec.describe "Papers", type: :request do
  describe "POST /papers" do
    let(:activity) { FactoryGirl.create(:activity) }
    let(:expired_activity) { FactoryGirl.create(:activity, :expired) }
    let(:user) { FactoryGirl.create(:user) }

    it "redirect to singin page before login" do
      visit new_activity_paper_url(activity)
      expect(page).to have_current_path(new_user_session_path)
    end

    it "cannot submit proposal after activity closed" do
      login_as user
      visit new_activity_paper_url(expired_activity)
      expect(page).to have_content("The event has not opened yet or already closed!")
    end

    it "creates new paper" do
      login_as user
      visit new_activity_paper_url(activity)

      within "#new_paper" do
        choose "Chinese"
        fill_in "Title", with: "Proposal Subject"
        fill_in "Abstract", with: "Some abstract for this proposal"
        fill_in "Outline", with: "Some outline for this proposal"
        fill_in "Bio", with: "Some speaker bio for this proposal"
        click_button "Submit Proposal"
      end

      expect(page).to have_content("Paper was successfully created.")
      expect(page).to have_content("Proposal Subject")
      expect(page).to have_content("Some abstract for this proposal")
      expect(page).to have_content("Some outline for this proposal")
      expect(page).to have_content("Some speaker bio for this proposal")
    end

  end
end
