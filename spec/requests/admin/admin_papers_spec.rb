require 'rails_helper'

RSpec.describe "Admin::Papers", type: :request do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:activity) { FactoryGirl.create(:activity) }

  describe "GET /admin/activity/:id/papers" do
    it "cannot viewed by non admin user" do
      user = FactoryGirl.create(:user)
      login_as user
      visit admin_activity_papers_url(activity)
      expect(page).to have_content("Permission Denied")
    end

    it "display specify activity's proposal" do
      papers = FactoryGirl.create_list(:paper, 5, activity: activity)
      login_as admin
      visit admin_activity_papers_url(activity)
      papers.each do |paper|
        expect(page).to have_content(paper.title)
      end
    end
  end

  describe "GET /admin/activity/:id/papers/:id" do
    let(:paper) { FactoryGirl.create(:paper, activity: activity) }

    it "display paper's detail information" do
      login_as admin
      visit admin_activity_paper_url(activity, paper)

      expect(page).to have_content(paper.title)
      expect(page).to have_content(paper.abstract)
      expect(page).to have_content(paper.outline)
      expect(page).to have_content(paper.pitch)
    end
  end

end
