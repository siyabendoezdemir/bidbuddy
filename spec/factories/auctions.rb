FactoryBot.define do
  factory :auction do
    startTime { 1.day.from_now }
    endTime { 3.days.from_now }
    currentPrice { 10.0 }
    status { "pending" }
    association :item
  end
end
