FactoryBot.define do
  factory :paper do
    sequence(:title) { |n| "Sample Paper #{n}" }
    abstract { "Sample abstract with long long long long long long content" }
    outline { "Sample outline with long content" }
    speaker_bio { "Speaker bio with long long long long long long content" }
    language { "Chinese" }
    user { FactoryBot.create(:user) }
    activity { FactoryBot.create(:activity) }

    trait :reviewed do
      state { :reviewed }
    end

    trait :accepted do
      state { :accepted }
    end

    trait :rejected do
      state { :rejected }
    end

    trait :withdrawn do
      state { :withdrawn }
    end

    factory :paper_with_review do
      transient do
        review_by { FactoryBot.create(:user) }
      end

      after(:create) do |paper, evaluator|
        create(:review, paper: paper, user: evaluator.review_by)
      end
    end

  end
end
