require "data_mapper"
require "dm-postgres-adapter"

database = ENV['DATABASE_URL'] || "postgres://localhost/collective_playlist_#{ENV['RACK_ENV']}"
DataMapper.setup(:default, database)

require_relative 'models/user'
require_relative 'models/playlist'

DataMapper.finalize
DataMapper.auto_upgrade!
