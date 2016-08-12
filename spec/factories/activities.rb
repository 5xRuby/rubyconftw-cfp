FactoryGirl.define do
  factory :activity do
    name "RubyConfTW"
    description "RubyConfTW is a conference of ruby in Taiwan"
    start_date { 1.day.ago }
    end_date { 30.day.from_now }
    open_at { 1.day.ago }
    close_at { 30.day.from_now }

    factory :activity_with_custom_field do
      transient do
        field_count 5
        field_type :text
      end

      after(:create) do |activity, evaluator|
        create_list(:custom_field, evaluator.field_count, activity: activity, field_type: evaluator.field_type)
      end
    end

  end
end
