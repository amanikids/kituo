ENV['RAILS_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require 'test_help'
require File.join(File.dirname(__FILE__), 'blueprints')
require 'redgreen' unless ENV['TM_PROJECT_DIRECTORY']

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
end
