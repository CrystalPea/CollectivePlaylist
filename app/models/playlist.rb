class Playlist
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :tracks_per_person, Integer
  property :admin_id, Integer

  has n, :users, :through => Resource
  has n, :tracks, :through => Resource
  has n, :requests

  validates_presence_of :title, :tracks_per_person, :admin_id

  def initialize params, session_id
    self.title = params[:title]
    self.description = params[:description]
    self.tracks_per_person = params[:tracks_per_person]
    self.admin_id = session_id
  end
end
