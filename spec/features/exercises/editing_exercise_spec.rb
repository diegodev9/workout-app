require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Editing Exercise', type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
    5.times do
      Exercise.create(workout: 'test', workout_date: DateTime.now, duration_in_min: rand(1..60), user_id: user.id)
    end
    # exercises.each{|exercise| exercise.save }
  end

  scenario 'with valid data succeeds' do
    visit '/'
    click_link 'My Lounge'

    link = "#{edit_user_exercise_path(user, Exercise.first)}"
    original_duration = Exercise.first.duration_in_min

    # puts user.id
    # puts "cantidad de ejercicios: #{Exercise.count}"
    # puts Exercise.all.map{|ex| "#{[ex.id, ex.user_id]}"}
    # puts "cantidad de ejercicios: #{Exercise.count}"
    # puts link
    # puts 'found' if find_link('', href: link2)

    click_link('', href: link)

    fill_in 'Duration', with: 45
    click_button 'Update Exercise'

    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).to_not have_content(original_duration)
  end
end
