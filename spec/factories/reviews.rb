FactoryGirl.define do
  factory :review do
    user { FactoryGirl.create(:user) }
    paper { FactoryGirl.create(:paper) }
  end
end
