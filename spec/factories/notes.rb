FactoryBot.define do
  factory :note do
    user { nil }
    title { "MyString" }
    body { "MyText" }
    public_share { false }
    completed { false }
  end
end
