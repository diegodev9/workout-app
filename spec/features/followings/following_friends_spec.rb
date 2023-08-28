require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Following friends', type: :feature do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before do
    user1
    user2
    sign_in user1
  end

  scenario 'if user signed in' do
    visit '/'

    expect(page).to have_content(user1.full_name)
    expect(page).to have_content(user2.full_name)

    href_ = "/friendships?friend_id=#{user1.id}"
    expect(page).not_to have_link("Follow", href: href_)

    link_ = "/friendships?friend_id=#{user2.id}"
    click_link('Follow', href: link_)

    href_ = "/friendships?friend_id=#{user2.id}"
    expect(page).not_to have_link("Follow", href: href_)
  end
end