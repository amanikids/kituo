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

  I18n.locale = 'en'
end

def human_date(day)
  I18n.localize(Chronic.parse(day).to_date, :format => :human).strip
end

module Chronic
  class << self
    def parse_with_month_support(input, options = {})
      if input == 'the second day of this month'
        Chronic.parse("the first day of this month", options) + 1.day
      else
        parse_without_month_support(input, options)
      end
    end

    alias_method_chain :parse, :month_support
  end
end
