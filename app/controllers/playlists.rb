class CollectivePlaylist < Sinatra::Base

  get '/playlists/new' do
    if current_user
      erb :'playlists/new'
    else flash.next[:error] = ["You need to be logged in to add a playlist"]
      redirect "/"
    end
  end

  post "/playlists" do
    playlist = Playlist.new(params, session[:id])
    playlist.users << current_user
    if playlist.save
      flash.next[:notice] = ["Your playlist '#{playlist.title}' has been created"]
      redirect "/playlists/view"
    else flash.next[:error] = playlist.errors.full_messages
      redirect "/playlists/new"
    end
  end

  get '/playlists/view' do
    erb :'playlists/view'
  end

  get '/playlists/:playlist_id' do
    @playlist = Playlist.get params[:playlist_id]
    erb :'playlists/id'
  end
end
