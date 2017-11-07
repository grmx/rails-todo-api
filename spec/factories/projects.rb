FactoryBot.define do
  factory :project do
    user nil
    title { Faker::Lorem.sentence }
  end
end
