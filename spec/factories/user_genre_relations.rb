FactoryBot.define do
  factory :user_genre_relation do
    association :user
    association :genre
  end
end
