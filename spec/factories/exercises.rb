FactoryBot.define do
  factory :exercise do
    workout { "workout #{rand(100..999)}" }
    duration_in_min { rand(1..99) }
    workout_date { Faker::Date.backward(days: rand(1..99)) }
    user
  end
end
