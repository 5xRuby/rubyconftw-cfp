FactoryBot.define do
  factory :review do
    user { FactoryBot.create(:user) }
    paper { FactoryBot.create(:paper) }
  end
end
