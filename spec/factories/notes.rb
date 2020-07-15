FactoryBot.define do
  factory :note do
    sequence :title do |n| 
     "Factory test Note no. #{n}"
    end
    # title { "test-title" }
    body { "test-bodyt" }
    public_share { false }
    completed { false }

    association :user

    trait :invalid do
      title { nil }
    end
  end
end
