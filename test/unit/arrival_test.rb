require 'test_helper'

class ArrivalTest < ActiveSupport::TestCase
  should_belong_to :child
  should_accept_nested_attributes_for :child
end
