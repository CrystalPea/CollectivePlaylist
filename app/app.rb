require 'sinatra/base'

class CollectivePlaylist < Sinatra::Base
  get '/' do
    'Welcome to Collective Playlist!'
  end

  get '/users/new' do
    erb :'users/new'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
