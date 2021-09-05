FactoryBot.define do
  factory :points_genre do
    genre_name { Faker::Lorem.word }
    point1 { Faker::Lorem.word }
    point2 { Faker::Lorem.word }
    point3 { Faker::Lorem.word }
    explanation { Faker::Lorem.sentence }
    association :user
  end
end
