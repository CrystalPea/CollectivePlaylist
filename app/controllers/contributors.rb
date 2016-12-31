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
    # require "pry"; binding.pry
    contributor = User.first(username: params[:existing_users_usernames])
    if contributor
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

end
