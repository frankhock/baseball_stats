require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'active_record'
require 'active_record_migrations'
require 'baseball_stats'

Dir.glob('lib/tasks/*.rake').each(&method(:import))

RSpec::Core::RakeTask.new(:spec)

ActiveRecordMigrations.configure do |c|
  c.yaml_config = 'config/database.yml'
end

ActiveRecordMigrations.load_tasks

task :environment do
  BaseballStats::Database.connection
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r baseball_stats.rb"
end

task :default => [:spec]
