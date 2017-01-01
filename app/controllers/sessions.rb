class CollectivePlaylist < Sinatra::Base

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
      user = User.authenticate(params)
    if user
      session[:id] = user.id
      flash.next[:notice] = ["Welcome to Collective Playlist, #{user.name}!"]
      redirect "/dashboard"
    else
      flash.next[:error] = ["Incorrect username and/or password"]
      redirect "/sessions/new"
    end
  end

  get '/sessions/delete' do
    session[:id] = nil
    session[:playlist_id] = nil
    flash.next[:notice] = ["Goodbye, we hope to see you again!"]
    redirect "/"
  end
end
