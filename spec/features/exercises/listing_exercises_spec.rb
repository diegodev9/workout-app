require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Listing exercises', type: :feature do
  let(:user) { create(:user) }
  let(:exercise1) { create(:exercise, user_id: user.id, workout_date: DateTime.now) }
  let(:exercise2) { create(:exercise, user_id: user.id, workout_date: DateTime.now) }
  let(:exercise3) { create(:exercise, user_id: user.id, workout_date: 8.days.ago ) }

  before do
    sign_in user
    exercise1
    exercise2
    exercise3
  end

  scenario "Shows user's workout for last 7 days" do
    visit '/'
    click_link 'My Lounge'

    expect(page).to have_content(exercise1.duration_in_min)
    expect(page).to have_content(exercise1.workout)
    expect(page).to have_content(exercise1.workout_date)

    expect(page).to have_content(exercise2.duration_in_min)
    expect(page).to have_content(exercise2.workout)
    expect(page).to have_content(exercise2.workout_date)

    expect(page).not_to have_content(exercise3.duration_in_min)
    expect(page).not_to have_content(exercise3.workout)
    expect(page).not_to have_content(exercise3.workout_date)
  end

  scenario "Shows no exercises if none created" do
    user.exercises.destroy_all
    visit '/'
    click_link 'My Lounge'
    expect(page).to have_content('No workouts yet')
  end

end