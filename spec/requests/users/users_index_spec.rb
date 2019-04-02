require 'rails_helper'

RSpec.describe "Users::Index", type: :request do
  describe "GET /my_propsoals" do

    let(:user) { FactoryBot.create(:user) }
    let(:activity) { FactoryBot.create(:activity) }

    it "display user submmited propoals" do
      papers = FactoryBot.create_list(:paper, 5, user: user)
      login_as user
      visit my_proposals_url

      papers.each do |paper|
        expect(page).to have_content(paper.title)
      end
    end
  end
end
