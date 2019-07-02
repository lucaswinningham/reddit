FactoryBot.define do
  factory :post do
    user
    sub
    title { Faker::Lorem.sentence }
    url { Faker::Internet.unique.url }
  end
end
