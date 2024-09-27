FactoryBot.define do
  factory :account do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123456" }
    sequence(:displayName) { |n| "User #{n}" }
    role { "buyer" }

    trait :seller do
      role { "seller" }
    end

    trait :admin do
      role { "admin" }
    end
  end
end
