require "bundler/gem_tasks"
require 'rspec/core/rake_task'

Dir.glob('lib/tasks/*.rake').each(&method(:import))

RSpec::Core::RakeTask.new(:spec)
