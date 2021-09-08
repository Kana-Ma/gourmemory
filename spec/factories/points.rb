FactoryBot.define do
  factory :point do
    point1 { Faker::Lorem.word }
    point2 { Faker::Lorem.word }
    point3 { Faker::Lorem.word }
    explanation { Faker::Lorem.sentence }
    association :user
    association :genre
  end
end
