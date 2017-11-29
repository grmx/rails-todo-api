FactoryBot.define do
  factory :comment do
    task { create(:task) }
    body { Faker::Lorem.paragraph }
  end
end
