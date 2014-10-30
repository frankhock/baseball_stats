require 'active_record'
require 'logger'
require 'sqlite3'
require 'yaml'

module BaseballStats::Database

  def self.config
    @@config = YAML::load(IO.read('config/database.yml'))
  end

  def self.env
    @@env = ENV['APP_ENV'] || BaseballStats::ENV
  end

  def self.connection
    ActiveRecord::Base.logger = Logger.new("log/#{self.env}.log")
    ActiveRecord::Base.establish_connection(config[self.env])
  end

end
