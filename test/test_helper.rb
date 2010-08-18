ENV['RAILS_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require 'test_help'
require File.join(File.dirname(__FILE__), 'blueprints')

# Running from rake, if we just require 'shoulda', shoulda sees the Spec
# constant defined by Cucumber (loaded in lib/tasks/testing.rake) and thinks
# it should run in RSpec mode instead of Test::Unit mode. Bad shoulda.
require 'shoulda/test_unit'
Shoulda.autoload_macros Gem.loaded_specs['paperclip'].full_gem_path, '.'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all

  setup do
    I18n.locale = 'en'
  end
end
