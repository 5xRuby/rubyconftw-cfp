require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do
  let(:user) { FactoryGirl.create(:user) }

  describe "PUT /users/edit" do
    it "updates user profile" do
      login_as user
      visit edit_user_registration_url

      within ".edit_user" do
        fill_in "Twitter", with: "rubyconftw"
        click_button "Update User"
      end

      expect(page).to have_content("Your account has been updated successfully.")
    end

    it "didn't update user profile when not fill required fields" do
      login_as user
      visit edit_user_registration_url

      within ".edit_user" do
        fill_in "Name", with: ""
        click_button "Update User"
      end

      expect(page).to have_css(".has-error")
    end
  end


end
