class CollectivePlaylist < Sinatra::Base
  helpers do
    def current_user
      User.get session[:id]
    end
  end

  get '/' do
    erb :index
  end
end
