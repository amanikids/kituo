ENV['RAILS_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require 'test_help'
require File.join(File.dirname(__FILE__), 'blueprints')
require 'redgreen' if STDOUT.tty?

Shoulda.autoload_macros Gem.loaded_specs['paperclip'].full_gem_path, '.'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all

  setup do
    I18n.locale = 'en'
  end
end
