require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Creating exercise', type: :feature do
  let(:user) { create(:user, email: 'user@example') }

  before do
    sign_in user
  end

  scenario 'with valid inputs' do
    visit '/'
    click_link 'My Lounge'
    click_link 'New Workout'
    expect(page).to have_link('Back')

    fill_in 'Duration', with: 70
    fill_in 'Workout Details', with: 'Weight lifting'
    fill_in 'Activity date', with: '2023-07-26'
    click_button 'Create Exercise'

    expect(page).to have_content('Exercise has been created')

    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(user, exercise))
    expect(exercise.user_id).to eq(user.id)
  end
end