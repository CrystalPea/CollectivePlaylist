require "data_mapper"
require "dm-postgres-adapter"
require_relative 'models/user'
require_relative 'models/playlist'
require_relative 'models/track'
require_relative 'models/request'

database = ENV['DATABASE_URL'] || "postgres://localhost/collective_playlist_#{ENV['RACK_ENV']}"
DataMapper.setup(:default, database)

DataMapper.finalize
DataMapper.auto_upgrade!
