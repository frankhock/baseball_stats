require 'active_record'
require 'logger'
require 'sqlite3'
require 'yaml'

module BaseballStats::Database
  extend self

  DEFAULT_ENV = "development".freeze

  attr_accessor :config

  @config = YAML::load(IO.read('config/database.yml'))

  def env
    @env = ENV['APP_ENV'] || DEFAULT_ENV
  end

  def connection
    ActiveRecord::Base.logger = Logger.new("log/#{self.env}.log")
    ActiveRecord::Base.establish_connection(config[self.env])
  end

end
