class Playlist
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :tracks_per_person, Integer

  belongs_to :user
  validates_presence_of :title, :tracks_per_person

  def initialize params
    self.title = params[:title]
    self.description = params[:description]
    self.tracks_per_person = params[:tracks_per_person]
  end
end
