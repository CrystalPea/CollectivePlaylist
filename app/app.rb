require 'sinatra/base'

class GraduationPlaylist < Sinatra::Base
  get '/' do
    'Hello GraduationPlaylist!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
