require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :name, String
  property :username, String
  property :email, String
  property :password_digest, Text

  attr_reader :password
  attr_accessor :password_confirmation

  validates_format_of :email, :as => :email_address
  validates_uniqueness_of :username, :email
  validates_confirmation_of :password

  def initialize params
    self.name = params[:name]
    self.username = params[:username]
    self.email = params[:email]
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]
  end

  def password= password
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
