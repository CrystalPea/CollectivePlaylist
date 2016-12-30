class CollectivePlaylist < Sinatra::Base

  get '/tracks/new' do
    if current_user
      session[:playlist_id] = params[:playlist_id]
      erb :'tracks/new'
    else flash.next[:error] = ["You need to be logged in to add a track"]
      redirect "/"
    end
  end


  post "/tracks" do
    playlist = Playlist.get(session[:playlist_id])
    track = Track.new params
    track.playlists << playlist
    track.users << current_user
    if track.save
      session[:playlist_id] = nil
      flash.next[:notice] = ["Track has been added to '#{playlist.title}'"]
      redirect "/playlists/view"
    else
      flash.next[:error] = track.errors.full_messages
      redirect "/tracks/new"
    end
  end
end
