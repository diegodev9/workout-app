require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Showing friend workout', type: :feature do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:exercise1) { create(:exercise, user_id: user1.id, workout_date: DateTime.now) }
  let(:exercise2) { create(:exercise, user_id: user2.id, workout_date: DateTime.now) }

  before do
    user1
    user2
    exercise1
    exercise2
    sign_in user1
    puts "#{user1.full_name} #{exercise1.workout} #{exercise1.user_id}"
    puts "#{user2.full_name} #{exercise2.workout} #{exercise2.user_id}"
    friend = Friend.create(user_id: user2.id)
    @following = Friendship.create(user_id: user1.id, friend_id: friend.id)
  end

  scenario 'shows friends workout for last 7 days' do
    visit '/'
    click_link 'My Lounge'
    click_link user2.full_name

    expect(page).to have_content(user2.full_name + "'s Exercises")
    expect(page).to have_content(exercise2.workout)
    expect(page).to have_css("canvas#myChart")
  end
end