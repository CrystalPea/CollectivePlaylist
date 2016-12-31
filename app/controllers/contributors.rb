class CollectivePlaylist < Sinatra::Base

  get "/contributors/new" do
    unless current_user && params[:playlist_id]
      flash.next[:error] = ["Something went wrong, try again."]
      redirect "/"
    end
    session[:playlist_id] = params[:playlist_id]
    @playlist = Playlist.get session[:playlist_id]
    erb :'contributors/new'
  end

  post "/contributors" do
    contributor = User.first(username: params[:existing_users_usernames])
    unless contributor
      flash.next[:error] = ["No such user in database."]
      redirect "/contributors/new"
    end
    playlist = Playlist.get session[:playlist_id]
    playlist.users << contributor
    if playlist.save
      flash.next[:notice] = ["#{contributor.name} has been added as a contributor to #{playlist.title}"]
      redirect "playlists/view"
    else
      flash.next[:error] = playlist.errors.full_messages
      redirect "/contributors/new"
    end
  end

end
