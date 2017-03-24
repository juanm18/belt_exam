class UsersController < ApplicationController
  def index
    @times_added = Playlist.includes(:song).where(song_id:params[:id], user_id: @user.id)
  end


  def new
  end

  def show
    @user = User.find params[:id]
    @times_added = Playlist.where(song_id:params[:id], user_id: @user.id)
    @my_songs = Playlist.includes(:song).where("user_id = ?", @user.id).references(:Playlist)
  end

  def login
    @user = User.find_by({email:params[:email], password: params[:password]})
    if @user
      session[:user_id] = @user.id
      session[:name] = @user.first_name
      redirect_to '/songs'
    else
      flash[:loginError] = "Invalid Login!"
      redirect_to '/'
    end
  end

  def create
    user = User.new(user_params)
    user.save
    if user.save
      session[:user_id] = user.id
      session[:name] = user.first_name
      redirect_to '/songs'
    else
      flash[:errors] = user.errors.full_messages.inspect
      redirect_to '/'
    end
  end

  def logout
    reset_session
    redirect_to '/'
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
