FactoryBot.define do
  factory :cohort do
    sequence(:name) { |n| "Cohort-#{n}" }
    
    association :user

    trait :invalid do
      name { nil }
    end
  end
end
