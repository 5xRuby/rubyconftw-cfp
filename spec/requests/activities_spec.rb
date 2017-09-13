require 'rails_helper'

RSpec.describe "Activities", type: :request do

  describe "GET /activities" do

    let! :activities do
      FactoryGirl.create_list(:activity, 2)
    end

    before do
      visit activities_url
    end

    it "displays the activities list" do
      expect(page).to have_content(activities.first.name)
      expect(page).to have_content(activities.second.name)
    end

    %w{title description image}.each do |mt|
      tag_css = sprintf('meta[name="og:%s"][content="%s"]', mt, I18n.t("meta.#{mt}"))
      it "has og:#{mt} meta tag" do
        expect(page).to have_css(tag_css, :visible => false, )
      end
    end

  end

  describe "GET /activities/:id but only id" do

    let! :activity do
      FactoryGirl.create(:activity)
    end

    it "should redirect if only use id in id param" do
      get "/activities/#{activity.id}"
      expect(response).to redirect_to(activity_url(activity))
    end

  end

  describe "GET /activities/:id" do

    let! :activity do
      FactoryGirl.create(:activity)
    end

    it "displays activities details" do
      visit activity_url(activity)
      expect(page).to have_content(activity.name)
      expect(page).to have_content(activity.description)
      expect(page).to have_content(activity.term)
    end
  end
end
