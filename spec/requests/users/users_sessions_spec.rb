require 'rails_helper'

RSpec.describe "Users::Sessions", type: :request do
  describe "GET /users/auth/:provide" do
    let(:auth_info) {
      OmniAuth::AuthHash.new({
        provider: 'github',
        info: {
          email: 'github@rubyconf.tw'
        }
      })
    }

    it "copy data from provider session" do
      visit new_user_session_url
      expect(page).to have_content("Sign in with Github")
      OmniAuth.config.mock_auth[:github] = auth_info
      click_link "Sign in with Github"
      expect(page).to have_content("You are already signed in.")
    end
  end
end
