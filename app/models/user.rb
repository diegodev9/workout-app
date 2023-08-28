class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :exercises

  validates :first_name, presence: true
  validates :last_name, presence: true

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
end
