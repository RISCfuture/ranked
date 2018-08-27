FactoryBot.define do
  factory :stack do
    name { FFaker::Lorem.word }
    card_names { (Array.new(10) { |i| FFaker::Lorem.word + i.to_s }).join("\n") }
  end
end
