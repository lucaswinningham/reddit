FactoryBot.define do
  factory :sub do
    sequence(:name) { Faker::Internet.unique.username(3..21, ['']) }
  end
end
