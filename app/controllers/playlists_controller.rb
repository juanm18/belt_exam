class PlaylistsController < ApplicationController
  def index
  end

  def add
    added = Playlist.new
    added.user_id = session[:user_id]
    added.song_id = params[:id]
    added.save
    if added.save
      song = Song.find(params[:id])
      song.count += 1
      song.save
      flash[:notice] = "Song Has been added to Playlist"
    else
      flash[:notice] = added.errors.full_messages.inspect
    end
      redirect_to '/songs'
  end
end
