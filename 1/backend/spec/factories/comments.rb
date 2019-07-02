FactoryBot.define do
  factory :comment do
    user
    content { Faker::Lorem.sentence }
    association :commentable, factory: :post
  end
end
