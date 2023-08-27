require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Deleting Exercise', type: :feature do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, workout_date: DateTime.now, user_id: user.id) }

  before do
    sign_in user
    exercise
  end

  scenario do
    visit '/'
    click_link "My Lounge"
    link = user_exercise_path(user, exercise)
    click_link('Destroy', href: link)

    expect(page).to have_content("Exercise has been deleted")
  end
end