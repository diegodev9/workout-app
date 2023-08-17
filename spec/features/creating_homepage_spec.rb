require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe 'Creating home page', type: :feature do
  scenario do
    visit '/'

    expect(page).to have_link('Home')
    expect(page).to have_link('Athletes Den')
    expect(page).to have_content('Workout Lounge!')
    expect(page).to have_content('Show off your workout')

  end
end