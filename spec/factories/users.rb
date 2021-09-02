FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.first_name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6, mix_case: true) }
    password_confirmation { password }
    prefecture_id         { Faker::Number.within(range: 2..48) }
    introduction          { Faker::Lorem.sentence }
  end
end