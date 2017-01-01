class CollectivePlaylist < Sinatra::Base

  get '/tracks/new' do
    unless current_user && (params[:playlist_id] || session[:playlist_id])
      flash.next[:error] = ["Something went wrong, try again."]
      redirect "/"
    end
      session[:playlist_id] = params[:playlist_id] if session[:playlist_id] == nil
      @playlist = Playlist.get session[:playlist_id]
      erb :'tracks/new'
  end


  post "/tracks" do
    unless session[:playlist_id]
      flash.next[:error] = "Something went wrong."
      redirect "/playlists/view"
    end
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
