FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    username { "MyString" }
    is_teacher { false }
  end
end
