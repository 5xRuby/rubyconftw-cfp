FactoryGirl.define do
  factory :custom_field do
    sequence(:name) { |n| "Field #{n}"}
    field_type :text
  end
end
