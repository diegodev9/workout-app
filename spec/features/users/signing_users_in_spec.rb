require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe 'Users sign in', type: :feature do
  let(:user) { create(:user, email: 'user@example.com') }

  scenario 'with valid credentials' do
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content("Signed in as #{user.email}")
  end
end