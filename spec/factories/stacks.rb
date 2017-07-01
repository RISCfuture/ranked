FactoryGirl.define do
  factory :stack do
    name { FFaker::Lorem.word }
    card_names { (Array.new(10) { FFaker::Lorem.word }).join("\n") }
  end
end
