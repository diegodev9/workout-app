require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Listing exercises', type: :feature do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:exercise1) { create(:exercise, workout: 'first', user_id: user1.id, workout_date: DateTime.now) }
  let(:exercise2) { create(:exercise, workout: 'second', user_id: user1.id, workout_date: DateTime.now) }
  let(:exercise3) { create(:exercise, workout: 'third', user_id: user1.id, workout_date: 9.days.ago ) }

  before do
    user1
    user2
    sign_in user1
    exercise1
    exercise2
    # exercise3
    friend = Friend.create(user_id: user2.id)
    FactoryBot.create(:friendship, user_id: user1.id, friend_id: friend.id)
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

    # expect(page).not_to have_content(exercise3.duration_in_min)
    # expect(page).not_to have_content(exercise3.workout)
    # expect(page).not_to have_content(exercise3.workout_date)
  end

  scenario "Shows no exercises if none created" do
    user1.exercises.destroy_all
    visit '/'
    click_link 'My Lounge'
    expect(page).to have_content('No workouts yet')
  end

  scenario 'shows a list of users friends' do
    visit '/'
    click_link 'My Lounge'

    expect(page).to have_content('My Friends')
    expect(page).to have_link(user2.full_name)
    expect(page).to have_link('Unfollow')
  end
end