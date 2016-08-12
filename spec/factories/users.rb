FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Tester #{n}" }
    sequence(:email) { |n| "user#{n}@rubyconf.tw"}
    password "12341234"

    trait :contributor do
      is_contributor true
    end

    trait :admin do
      is_admin true
    end
  end
end
