FactoryBot.define do
  factory :bid do
    amount { 15.0 }
    timestamp { Time.current }
    association :auction
    association :bidder, factory: :account, role: "buyer"
  end
end
