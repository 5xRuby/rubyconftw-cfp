FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Tester #{n}" }
    sequence(:email) { |n| "user#{n}@rubyconf.tw"}
    sequence(:github_username) { |n| "github_#{n}" }
    sequence(:uid) { |n| "#{10000+n}" }
    sequence(:twitter) { |n| "@user#{n}"}
    provider "github"
    password "12341234"

    title "title"
    company "company"

    trait :contributor do
      is_contributor true
    end

    trait :admin do
      is_admin true
    end
  end
end
