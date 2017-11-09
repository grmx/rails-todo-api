FactoryBot.define do
  factory :project do
    user { create(:user) }
    title { Faker::Lorem.sentence }
  end
end
