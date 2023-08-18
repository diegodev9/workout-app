FactoryBot.define do
  factory :exercise do
    workout { "MyText" }
    duration_in_min { 1 }
    workout_date { "2023-08-18" }
    user { nil }
  end
end
