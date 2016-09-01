require 'rails_helper'

RSpec.describe "Papers", type: :request do
  let(:activity) { FactoryGirl.create(:activity) }
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before(:each) { login_as user }

  describe "GET /papers/new" do
    let(:expired_activity) { FactoryGirl.create(:activity, :expired) }

    it "redirect to singin page before login" do
      logout :user
      visit new_activity_paper_url(activity)
      expect(page).to have_current_path(new_user_session_path)
    end

    it "cannot submit proposal after activity closed" do
      visit new_activity_paper_url(expired_activity)
      expect(page).to have_content("The event has not opened yet or already closed!")
    end
  end

  describe "POST /papers" do
    before(:each) { visit new_activity_paper_url(activity) }

    it "creates new paper" do
      within ".new_paper" do
        choose "Chinese"
        fill_in "Title", with: "Proposal Subject"
        fill_in "Abstract", with: "Some abstract for this proposal" * 5
        fill_in "Outline", with: "Some outline for this proposal"
        fill_in "Bio", with: "Some speaker bio for this proposal" * 5
        click_button "Submit Proposal"
      end

      expect(page).to have_content("Paper was successfully created.")
      expect(page).to have_content("Chinese")
      expect(page).to have_content("Proposal Subject")
      expect(page).to have_content("Some abstract for this proposal")
      expect(page).to have_content("Some outline for this proposal")
      expect(page).to have_content("Some speaker bio for this proposal")
    end

    it "shows error when not fill all requred information" do
      within "#new_paper" do
        click_button "Submit Proposal"
      end

      expect(page).to have_css(".has-error")
    end
  end

  describe "PUT /papers/:id" do
    it "cannot edit other user's proposal" do
      paper = FactoryGirl.create(:paper, activity: activity, user: other_user)

      visit edit_activity_paper_url(activity, paper)
      expect(page).to have_content("You are not authorized to access this page.")
    end

    it "updates the proposal" do
      paper = FactoryGirl.create(:paper, activity: activity, user: user)

      visit edit_activity_paper_url(activity, paper)

      within ".edit_paper" do
        choose "English"
        fill_in "Title", with: "Proposal Subject"
        fill_in "Abstract", with: "Some abstract for this proposal" * 5
        fill_in "Outline", with: "Some outline for this proposal"
        fill_in "Bio", with: "Some speaker bio for this proposal" * 5
        click_button "Submit Proposal"
      end

      expect(page).to have_content("Paper was successfully updated.")
      expect(page).to have_content("English")
      expect(page).to have_content("Proposal Subject")
      expect(page).to have_content("Some abstract for this proposal")
      expect(page).to have_content("Some outline for this proposal")
      expect(page).to have_content("Some speaker bio for this proposal")
    end

    it "shows error when not fill required fields" do
      paper = FactoryGirl.create(:paper, activity: activity, user: user)

      visit edit_activity_paper_url(activity, paper)

      within ".edit_paper" do
        fill_in "Title", with: ""
        click_button "Submit Proposal"
      end

      expect(page).to have_css(".has-error")
    end
  end

  describe "DELETE /papers/:id" do
    it "cannot withdraw other user's proposal" do
      paper = FactoryGirl.create(:paper, activity: activity, user: other_user)

      visit activity_paper_url(activity, paper)
      expect(page).to have_content("You are not authorized to access this page.")
    end

    it "withdraws the proposal" do
      paper = FactoryGirl.create(:paper, activity: activity, user: user)

      visit activity_paper_url(activity, paper)
      click_link "Withdraw Proposal"
      expect(page).to have_content("Paper was successfully withdrawn.")
    end
  end

end
