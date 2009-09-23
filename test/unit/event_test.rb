require File.join(File.dirname(__FILE__), '..', 'test_helper')

class EventTest < ActiveSupport::TestCase
  should_validate_presence_of :happened_on
  should_allow_values_for :happened_on, Date.yesterday, Date.today
  should_not_allow_values_for :happened_on, Date.tomorrow
end
