class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :exercises
  has_many :friendships
  has_many :friends, through: :friendships
  has_one :room

  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :create_chatroom

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search_by_name(name)
    names_array = name.split(' ')

    if names_array.count == 1
      where('first_name LIKE ?', "%#{names_array.first}%").or(where('last_name LIKE ?', "%#{names_array.first}%")).order(:first_name)
    else
      where('first_name LIKE ?', "%#{names_array.first}%")
        .or(where('first_name LIKE ?', "%#{names_array.last}%"))
        .or(where('last_name LIKE ?', "%#{names_array.first}%"))
        .or(where('last_name LIKE ?', "%#{names_array.last}%"))
    end
  end

  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end

  def current_friendship(friend)
    friendships.where(friend: friend).first
  end

  private

  def create_chatroom
    hyphenated_username = self.full_name.split.join('-')
    Room.create(name: hyphenated_username, user_id: self.id)
  end
end
