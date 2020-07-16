FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@mail.com" }
    password { "testpassword" }
    username { "Some Name" }
    is_teacher { false }
  end
  trait :invalid_user do
    email { nil }
  end
end
