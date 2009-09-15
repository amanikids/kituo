ENV['RAILS_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '..', '..', '..', 'config', 'environment')
require Rails.root.join('test', 'blueprints')
require 'cucumber/rails/world'
require 'cucumber/formatter/unicode' # Comment out this line if you don't want Cucumber Unicode support
Cucumber::Rails.bypass_rescue # Comment out this line if you want Rails own error handling

require 'webrat'

Webrat.configure do |config|
  config.mode = :selenium
end

class Webrat::SeleniumSession
  def setup #:nodoc:
    # FIXME Selenium doesn't work (why not?) when webrat starts it, you
    # have to start it externally via the "selenium" command (installed
    # by the Selenium gem)

#    Webrat::Selenium::SeleniumRCServer.boot
    Webrat::Selenium::SeleniumRCServer.new.wait
    Webrat::Selenium::ApplicationServer.boot

    create_browser
    $browser.start

    extend_selenium
    define_location_strategies
    $browser.window_maximize
  end
end
