FactoryGirl.define do
  factory :paper do
    title "Sample Paper"
    abstract "Sample abstract with long content"
    outline "Sample outline with long content"
    speaker_bio "Speaker bio with long content"
    language "Chinese"
    user { FactoryGirl.create(:user) }
    activity { FactoryGirl.create(:activity) }
  end
end
