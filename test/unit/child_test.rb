require 'test_helper'

class ChildTest < ActiveSupport::TestCase
  should_have_many :arrivals
  # TODO: reconsider if we really want to be so open with our arrivals
  should_accept_nested_attributes_for :arrivals
end
