require 'rails_helper'

RSpec.describe "Activities", type: :request do
  describe "GET /activities" do

    let :activity do
      FactoryGirl.create :activity
    end

    it 'when landing home page' do
      get root_path
      expect(response.body).to include(activity.name)
    end
  end
end
