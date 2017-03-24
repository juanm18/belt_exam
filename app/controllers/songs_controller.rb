class SongsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @songs = Song.all
  end

  def new
  end

  def create
    song = Song.new
    song.title = params[:title]
    song.artist = params[:artist]
    song.save
    if song.save
      redirect_to '/songs'
    else
      flash[:songError] = song.errors.full_messages.inspect
      redirect_to '/songs'
    end
  end

  def show
    @song = Song.find(params[:id])
    @users = Playlist.includes(:user).where("song_id = ?", params[:id])
    @my_count = Playlist.find_by(song_id:@song.id, user_id:session[:user_id] )
  end
end
