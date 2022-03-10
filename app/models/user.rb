class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :playlists
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def authenticate(password)
    valid_password?(password)
  end
end
