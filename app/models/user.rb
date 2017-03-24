class User < ActiveRecord::Base
  has_many :playlists
  has_many :songs, :through => :playlists

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name , presence:true, length: {minimum:3}
  validates :email ,presence:true, uniqueness:{case_sensative:false}, format:{with:EMAIL_REGEX}
  validates :password ,presence:true , length:{minimum:7}
end
