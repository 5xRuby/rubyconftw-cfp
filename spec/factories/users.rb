FactoryGirl.define do
  factory :user do
    name "Tester"
    sequence(:email) { |n| "user#{n}@rubyconf.tw"}
    password "12341234"
  end
end
