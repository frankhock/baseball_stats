require 'rubygems'
require 'active_record'
require 'sqlite3'

require "baseball_stats/version"
require 'baseball_stats/database'

Dir[File.join(__dir__, 'baseball_stats/models/*.rb')].each { |f| require f }

module BaseballStats
  include Database

  APP_ROOT = File.expand_path("../..", __FILE__)
  ENV      = ENV['APP_ENV'] || 'development'

  # make database connection
  Database.connection

end
