require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'User sign out', type: :feature do
  let(:user) { create(:user, email: 'user@example.com') }

  before do
    sign_in user
  end

  scenario 'User sing out' do
    visit '/'
    click_link 'Sign out'
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Sign up')
    expect(page).not_to have_content('Sign out')
  end
end