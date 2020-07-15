FactoryBot.define do
  factory :cohort do
    sequence(:name) { |n| "Cohort-#{n}" }
    association :user
  end
end
