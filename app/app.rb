ENV['RACK_ENV'] = 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class CollectivePlaylist < Sinatra::Base
  use Rack::MethodOverride
  enable :sessions
  set :session_secret, "himitsu"
  register Sinatra::Flash
  set :app_file, __FILE__

  get '/' do
    'Welcome to Collective Playlist!'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    new_user = User.new(params)
    session[:id] = new_user.id if new_user.save
    if session[:id]
      flash.next[:notice] = ["Welcome to Collective Playlist, #{params[:name]}!"]
      redirect "/dashboard"
    else
      flash.next[:error] = new_user.errors.full_messages
      redirect "/users/new"
    end
  end

  get '/dashboard' do
    erb :dashboard
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
