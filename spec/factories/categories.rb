FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "test-category-#{n}" }
  end
end
