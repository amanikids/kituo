ENV['RAILS_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment')
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
  I18n.locale = 'en'
  [Caregiver, Child, Event, ScheduledVisit].each(&:delete_all)
end

After do
  [Caregiver, Child, Event, ScheduledVisit].each(&:delete_all)
end

def human_date(day)
  I18n.localize(Chronic.parse(day).to_date, :format => :human).strip
end
