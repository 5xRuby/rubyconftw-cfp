require 'rails_helper'

RSpec.describe "Admin::Stats", type: :request do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:custom_fields) { FactoryGirl.create_list(:custom_field, 5, activity: activity) }
  let!(:papers) { FactoryGirl.create_list(:paper, 5, activity: activity, answer_of_custom_fields: answer_of_custom_fields) }
  let!(:accepted_papers) { FactoryGirl.create_list(:paper, 5, :accepted, activity: activity, answer_of_custom_fields: answer_of_custom_fields) }

  let(:answer_of_custom_fields) do
    answer = {}
    custom_fields.each do |field|
      answer[field.id.to_s] = "Example answer"
    end
    answer
  end

  before(:each) { login_as admin }

  describe "GET /admin/activities/:id/stats" do
    before(:each) do
      visit admin_activity_stats_url(activity)
    end

    it "cannot viewed by non-admin user" do
      user = FactoryGirl.create(:user)
      login_as user
      visit admin_activity_stats_url(activity)
      expect(page).to have_content("Permission Denied")
    end

    it "display custom fields stats" do
      custom_fields.each do |field|
        expect(page).to have_content(field.name)
      end
    end

    it "display only accepted papers stats" do
      visit admin_activity_stats_url(activity, {speaker_only: true})

      papers.each do |paper|
        expect(page).not_to have_content(paper.user.name)
      end

      accepted_papers.each do |paper|
        expect(page).to have_content(paper.user.name)
        expect(page).to have_content("Example answer")
      end
    end

  end
end
