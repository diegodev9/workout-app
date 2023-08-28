require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Searching for user', type: :feature do
  let(:user1) { create(:user, last_name: 'Doe') }
  let(:user2) { create(:user, last_name: 'Doe') }

  before do
    user1
    user2
  end

  scenario 'with existing name returns all those users' do
    visit '/'
    fill_in "search_name", with: 'Doe'
    click_button "Search"

    expect(page).to have_content(user1.full_name)
    expect(page).to have_content(user2.full_name)
    expect(current_path).to eq('/dashboards/search')
  end
end