require 'rails_helper'

RSpec.describe Admin::PapersController, type: :controller do

  shared_examples "do not search" do
    it "has same @papers as papers" do
      papers = [paper1, paper2, paper3]
      get :index, params: params
      expect(assigns(:papers)).to match_array papers
    end
  end
  
  describe "search ability in #index" do
  
    let(:admin) { FactoryBot.create(:user, :admin) }
    let(:activity) { FactoryBot.create(:activity_with_custom_field) }
    let(:params) {
      {
        activity_id: activity.permalink,
        commit: commit,
        search_field: search_field,
        search_type: search_type,
        search_key: search_key,
      }
    }
    let(:search_field) { }
    let(:search_type) { }
    let(:search_key) { }

    let!(:paper1) { FactoryBot.create(:paper, activity: activity) }
    let!(:paper2) { FactoryBot.create(:paper, activity: activity) }
    let!(:paper3) { FactoryBot.create(:paper, activity: activity) }

    before do
       sign_in admin
    end

    context "Commit is not 'Search'" do
      let(:commit) { "Clear Search" }
      it_behaves_like "do not search"
    end

    context "Commit is 'Search'" do
      let(:commit) { "Search" }

      context "when search_field is not one of the fixed key or the custom fields" do
        let(:search_field) { "__NOT_EXIST__" }
        it_behaves_like "do not search"
      end
      
      context "with 'equal'" do
        let(:search_type) { "equal" }
        context "when search on fixed fields" do
          let(:bio_1) { Faker::Lorem.sentence(11) }
          let(:bio_2) { bio_1 + "__DIFFERENT__" }
          let!(:paper1) { FactoryBot.create(:paper, activity: activity, speaker_bio: bio_1) }
          let!(:paper2) { FactoryBot.create(:paper, activity: activity, speaker_bio: bio_1) }
          let!(:paper3) { FactoryBot.create(:paper, activity: activity, speaker_bio: bio_2) }
          let(:search_field) { "speaker_bio" }
          let(:search_key) { bio_1 }
          
          it "returns matched results" do
            valid_papers = [paper1, paper2]
            get :index, params: params
            expect(assigns(:papers)).to match_array valid_papers
          end
        end

        context "when search on custom fields" do
          let(:custom_1) { {"#{activity.custom_fields[0].id}"=>"Talk(30 mins)"} }
          let(:custom_2) { {"#{activity.custom_fields[0].id}"=>"Session(55 mins)"} }
          let!(:paper1) { FactoryBot.create(:paper, activity: activity, answer_of_custom_fields: custom_1) }
          let!(:paper2) { FactoryBot.create(:paper, activity: activity, answer_of_custom_fields: custom_1) }
          let!(:paper3) { FactoryBot.create(:paper, activity: activity, answer_of_custom_fields: custom_2) }
          let(:search_field) { activity.custom_fields[0].name }
          let(:search_key) { "Talk(30 mins)" }

          it "returns matched results" do
            valid_papers = [paper1, paper2]
            get :index, params: params
            expect(assigns(:papers)).to match_array valid_papers
          end
        end
      end

      context "with 'like'" do
        let(:search_type) { "like" }
        context "when search on fixed fields" do
          let(:bio_1) { "#{Faker::Lorem.sentence(10)} UNIQUE_SEARCH_KEY #{Faker::Lorem.sentence(10)}" }
          let(:bio_2) { "#{Faker::Lorem.sentence(10)} OTEHR #{Faker::Lorem.sentence(10)}" }
          let!(:paper1) { FactoryBot.create(:paper, activity: activity, speaker_bio: bio_1) }
          let!(:paper2) { FactoryBot.create(:paper, activity: activity, speaker_bio: bio_1) }
          let!(:paper3) { FactoryBot.create(:paper, activity: activity, speaker_bio: bio_2) }
          let(:search_field) { "speaker_bio" }
          let(:search_key) { "UNIQUE_SEARCH_KEY" }
          
          it "returns matched results" do
            valid_papers = [paper1, paper2]
            get :index, params: params
            expect(assigns(:papers)).to match_array valid_papers
          end
        end

        context "when search on custom fields" do
          let(:custom_1) { {"#{activity.custom_fields[0].id}"=>"#{Faker::Lorem.sentence(10)} UNIQUE_SEARCH_KEY #{Faker::Lorem.sentence(10)}"} }
          let(:custom_2) { {"#{activity.custom_fields[0].id}"=>"#{Faker::Lorem.sentence(10)} OTEHR #{Faker::Lorem.sentence(10)}"} }
          let!(:paper1) { FactoryBot.create(:paper, activity: activity, answer_of_custom_fields: custom_1) }
          let!(:paper2) { FactoryBot.create(:paper, activity: activity, answer_of_custom_fields: custom_1) }
          let!(:paper3) { FactoryBot.create(:paper, activity: activity, answer_of_custom_fields: custom_2) }
          let(:search_field) { activity.custom_fields[0].name }
          let(:search_key) { "UNIQUE_SEARCH_KEY" }

          it "returns matched results" do
            valid_papers = [paper1, paper2]
            get :index, params: params
            expect(assigns(:papers)).to match_array valid_papers
          end
        end
      end
    end
  end
end
