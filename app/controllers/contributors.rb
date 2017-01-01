class CollectivePlaylist < Sinatra::Base

  get "/contributors/new" do
    unless current_user && (params[:playlist_id] || session[:playlist_id])
      flash.next[:error] = ["Something went wrong, try again."]
      redirect "/"
    end
    session[:playlist_id] = params[:playlist_id] if session[:playlist_id] == nil
    # require "pry"; binding.pry
    @playlist = Playlist.get session[:playlist_id]
    erb :'contributors/new'
  end

  post "/contributors" do
    playlist = Playlist.get session[:playlist_id]
    before = []
    (playlist.users).each { |user| before << user }
    if params[:existing_users_usernames].include?(",")
      contributors = params[:existing_users_usernames].split(",")
      contributors.each do |contributor|
        user = User.first(username: contributor)
        unless user
          flash.next[:error] = ["No such user as #{contributor} in database."]
          redirect "/contributors/new"
        end
        playlist.users << user
      end
    else
      contributor = User.first(username: params[:existing_users_usernames])
      unless contributor
        flash.next[:error] = ["No such user in database."]
        redirect "/contributors/new"
      end
      playlist.users << contributor
    end
    if playlist.save
      messages = []
      (playlist.users - before).each do |user|
        messages << "#{user.name} has been added as a contributor to #{playlist.title}"
      end
        session[:playlist_id] = nil
        flash.next[:notice] = messages
      redirect "playlists/view"
    else
      flash.next[:error] = playlist.errors.full_messages
      redirect "/contributors/new"
    end
  end

end
