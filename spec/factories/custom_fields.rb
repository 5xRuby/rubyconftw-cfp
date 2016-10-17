FactoryGirl.define do
  factory :custom_field do
    sequence(:name) { |n| "Field #{n}"}
    field_type :text

    trait :checkboxes do
      field_type :checkboxes
    end
  end
end
