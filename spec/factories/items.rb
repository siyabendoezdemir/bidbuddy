FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    description { "A great item for auction" }
    startingPrice { 10.0 }
    association :seller, factory: :account, role: "seller"
  end
end
