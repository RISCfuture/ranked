FactoryBot.define do
  factory :card do
    association :stack
    sequence(:name) { |i| "Card #{i}" }
  end
end
