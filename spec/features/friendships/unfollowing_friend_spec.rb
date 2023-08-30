require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Unfollowing friend', type: :feature do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before do
    user1
    user2
    sign_in user1
    friend = Friend.create(user_id: user2.id)
    @following = Friendship.create(user_id: user1.id, friend_id: friend.id)
  end

  scenario do
    visit '/'
    click_link 'My Lounge'
    href_ = "/friendships/#{@following.id}"
    puts "#{Friendship.count} #{Friendship.first.user.full_name} #{Friendship.first.friend.user.full_name}"
    click_link('Unfollow', href: href_)

    expect(page).to have_content("#{user2.full_name} unfollowed")
  end
end