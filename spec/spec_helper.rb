ENV["APP_ENV"] ||= 'test'
require 'rspec'

$LOAD_PATH << 'lib'
require 'baseball_stats'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each {|f| require f}

RSpec.configure do |config|

end
