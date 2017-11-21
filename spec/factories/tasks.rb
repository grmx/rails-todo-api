FactoryBot.define do
  factory :task do
    project { create(:project) }
    title { Faker::Lorem.sentence }
    done false
    position 0
    deadline nil
  end
end
