class Track
  include DataMapper::Resource

  property :id, Serial
  property :artist, String
  property :title, String

  validates_presence_of :artist, :title

  def initialize params
    self.artist = params[:artist]
    self.title = params[:title]
  end
end
