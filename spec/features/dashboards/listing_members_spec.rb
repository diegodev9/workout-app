require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Listing members', type: :feature do
  let(:john) { create(:user, first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password') }
  let(:sarah) { create(:user, first_name: 'Sarah', last_name: 'Doe', email: 'sarah@example.com', password: 'password') }

  before do
    john
    sarah
  end

  scenario 'shows a list of registered members' do
    visit '/'
    expect(page).to have_content('List of Members')
    expect(page).to have_content(john.full_name)
    expect(page).to have_content(sarah.full_name)
  end
end