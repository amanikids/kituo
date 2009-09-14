ENV['RAILS_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require 'test_help'
require File.join(File.dirname(__FILE__), 'blueprints')
require 'redgreen' unless ENV['TM_PROJECT_DIRECTORY']

# Running from rake, if we just require 'shoulda', shoulda sees the Spec
# constant defined by Cucumber (loaded in lib/tasks/testing.rake) and thinks
# it should run in RSpec mode instead of Test::Unit mode. Bad shoulda.
require 'shoulda/test_unit'
require 'shoulda/rails'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
end
