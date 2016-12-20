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

  def initialize params
    self.name = params[:name]
    self.username = params[:username]
    self.email = params[:email]
    self.password = params[:password]
  end

  def password= password
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end