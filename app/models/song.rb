class Song < ActiveRecord::Base
  validates :title, :artist, presence: true, length: {minimum: 2}

  has_many :playlists
  has_many :users, through: :playlists
end
