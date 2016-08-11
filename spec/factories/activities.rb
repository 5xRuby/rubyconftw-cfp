FactoryGirl.define do
  factory :activity do
    name "RubyConfTW"
    description "RubyConfTW is a conference of ruby in Taiwan"
    start_date { 1.day.ago }
    end_date { 30.day.from_now }
    open_at { 1.day.ago }
    close_at { 30.day.from_now }
  end
end
