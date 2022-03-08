class Playlist < ApplicationRecord
  has_many :videos
  belongs_to :user

  validates :name , presence: true
end
