FactoryBot.define do
  factory :vote do
    user
    association :voteable, factory: :post
  end
end
