FactoryBot.define do
  factory :note do
    title { "test-title" }
    body { "test-bodyt" }
    public_share { false }
    completed { false }

    association :user
  end
end
