class CollectivePlaylist < Sinatra::Base

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    new_user = User.new(params)
    session[:id] = new_user.id if new_user.save
    if session[:id]
      flash.next[:notice] = ["Welcome to Collective Playlist, #{params[:name]}!"]
      redirect "/"
    else
      flash.next[:error] = new_user.errors.full_messages
      redirect "/users/new"
    end
  end
end
