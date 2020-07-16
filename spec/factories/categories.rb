FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "test-category-#{n}" }
  end
  trait :invalid do
    name { nil }
  end
end
