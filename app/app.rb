ENV['RACK_ENV'] = 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'
require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/playlists'
require_relative 'controllers/tracks'
require_relative 'controllers/contributors'
require_relative 'controllers/requests'
require_relative 'server'

class CollectivePlaylist < Sinatra::Base
  use Rack::MethodOverride
  enable :sessions
  set :session_secret, "himitsu"
  register Sinatra::Flash
  set :app_file, __FILE__


  # start the server if ruby file executed directly
  run! if app_file == $0
end
