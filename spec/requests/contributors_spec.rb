require 'rails_helper'

RSpec.describe "Contributors", type: :request do
  describe "GET /contributors" do
    it "show list of contributors" do
      contributors = FactoryGirl.create_list(:user, 5, :contributor)

      visit contributors_url
      contributors.each do |contributor|
        expect(page).to have_content(contributor.name)
      end
    end
  end
end
