ENV['RAILS_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '..', '..', '..', 'config', 'environment')
require Rails.root.join('test', 'blueprints')
require 'cucumber/rails/world'
require 'cucumber/formatter/unicode' # Comment out this line if you don't want Cucumber Unicode support
Cucumber::Rails.bypass_rescue # Comment out this line if you want Rails own error handling

require 'webrat'
require 'webrat/integrations/selenium'

Webrat.configure do |config|
  config.mode = :selenium
end

Before do
  # FIXME how shall we clean the database before each run?
  [Caregiver, Child, Event, ScheduledVisit].each(&:delete_all)
end
