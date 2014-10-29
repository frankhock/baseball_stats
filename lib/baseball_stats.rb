require 'active_record'
require 'sqlite3'

require "baseball_stats/version"
require 'baseball_stats/database'

module BaseballStats
  include Database
end
