require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'active_record'
require 'active_record_migrations'

Dir.glob('lib/tasks/*.rake').each(&method(:import))

RSpec::Core::RakeTask.new(:spec)

ActiveRecordMigrations.configure do |c|
  c.yaml_config = 'config/database.yml'
end

ActiveRecordMigrations.load_tasks

task :environment do
  BaseballStats::Database.connection
end

task :default => [:spec]
