FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.first_name }
    email                 { Faker::Internet.free_email }

    password = Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)
    password              { password }
    password_confirmation { password }

    prefecture_id         { Faker::Number.within(range: 2..48) }
    introduction          { Faker::Lorem.sentence }
  end
end
