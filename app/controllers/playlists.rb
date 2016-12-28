class CollectivePlaylist < Sinatra::Base

  get '/playlists/new' do
    if current_user
      erb :'playlists/new'
    else flash.next[:error] = ["You need to be logged in to add a playlist"]
      redirect "/"
    end
  end

  post "/playlists" do
    new_playlist = Playlist.new(params, session[:id])
    if new_playlist.save
      flash.next[:notice] = ["Your playlist '#{new_playlist.title}' has been created"]
      redirect "/playlists/view"
    else flash.next[:error] = new_playlist.errors.full_messages
      redirect "/playlists/new"
    end
  end

  get '/playlists/view' do
    erb :'playlists/view'
  end
end
