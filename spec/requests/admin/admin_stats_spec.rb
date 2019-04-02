require 'rails_helper'

RSpec.describe "Admin::Stats", type: :request do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let!(:activity) { FactoryBot.create(:activity) }
  let!(:custom_fields) { FactoryBot.create_list(:custom_field, 5, activity: activity) }
  let!(:papers) { FactoryBot.create_list(:paper, 5, activity: activity, tag_list: "papers", answer_of_custom_fields: answer_of_custom_fields) }
  let!(:accepted_papers) { FactoryBot.create_list(:paper, 5, :accepted, tag_list: "accepted", activity: activity, answer_of_custom_fields: answer_of_custom_fields) }

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
      user = FactoryBot.create(:user)
      login_as user
      visit admin_activity_stats_url(activity)
      expect(page).to have_content("Permission Denied")
    end

    it "display custom fields stats" do
      custom_fields.each do |field|
        expect(page).to have_content(field.name)
      end
    end

    it "display taggings count only this activity" do
      FactoryBot.create_list(:paper, 5, tag_list: "papers")

      expect(page).to have_content("papers")
      expect(page).to have_selector('#taggings_count tbody tr td', text: papers.count)
    end
  end

  describe "/admin/activities/:id/stats?speaker_only" do
    before(:each) do
      visit admin_activity_stats_url(activity, {speaker_only: true})
    end

    it "display only accepted papers stats" do
      papers.each do |paper|
        expect(page).not_to have_content(paper.user.name)
      end

      accepted_papers.each do |paper|
        expect(page).to have_content(paper.user.name)
        expect(page).to have_content("Example answer")
      end
    end

    it "display only accepted papers tags" do
      expect(page).to have_content("accepted")
      expect(page).not_to have_content("papers")
    end

  end
end
