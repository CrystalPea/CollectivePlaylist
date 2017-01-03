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

  get "/requests/view" do
    unless current_user
      flash.next[:error] = ["You need to be logged in to view your requests"]
      redirect "/"
    end
    erb :'/requests/view'
  end

  post "/requests/respond" do
    request = Request.get params[:request_id]
    if params[:response] == "Accept"
      request.accepted = true
      request.playlist.users << request.user
      request.playlist.save
      request.save
      flash.next[:notice] = ["#{request.user.name} has been added as #{request.playlist.title} contributor"]
      redirect "/requests/view"
    else
      request.rejected = true
      request.save
      flash.next[:notice] = ["#{request.user.name}'s request has been rejected."]
      redirect "/requests/view"
    end

  end
end
