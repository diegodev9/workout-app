require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Creating exercise', type: :feature do
  let(:user) { create(:user, email: 'user@example') }

  before do
    sign_in user

    visit '/'
    click_link 'My Lounge'
    click_link 'New Workout'
    expect(page).to have_link('Back')
  end

  scenario 'with valid inputs' do
    fill_in 'Duration', with: 70
    fill_in 'Workout Details', with: 'Weight lifting'
    fill_in 'Activity date', with: 3.days.ago
    click_button 'Create Exercise'

    expect(page).to have_content('Exercise has been created')

    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(user, exercise))
    expect(exercise.user_id).to eq(user.id)
  end

  scenario 'with invalid inputs' do
    fill_in 'Duration', with: ''
    fill_in 'Workout Details', with: ''
    fill_in 'Activity date', with: ''
    click_button 'Create Exercise'

    expect(page).to have_content('Exercise has not been created')
    expect(page).to have_content('Duration in min is not a number')
    expect(page).to have_content("Workout details can't be blank")
    expect(page).to have_content("Activity date can't be blank")
  end
end