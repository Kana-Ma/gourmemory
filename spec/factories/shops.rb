FactoryBot.define do
  factory :shop do
    shop_name { Faker::Lorem.word }
    address { Faker::Address.full_address }
    total_rate { 3.5 }
    rate1 { 4 }
    rate2 { 3.5 }
    rate3 { 3 }
    text { Faker::Lorem.sentence }
    association :user
    association :genre
    association :point

    after(:build) do |shop|
      shop.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
