class CollectivePlaylist < Sinatra::Base
  post '/requests' do
    session[:playlist_id] = params[:playlist_id]
    playlist = Playlist.get session[:playlist_id]
    request = Request.new
    playlist.requests << request
    current_user.requests << request
    request.save
    flash.next[:notice] = ["Your request has been sent"]
    redirect "/playlists/view"
  end
end
