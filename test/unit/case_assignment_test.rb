require File.join(File.dirname(__FILE__), '..', 'test_helper')

class CaseAssignmentTest < ActiveSupport::TestCase
  should_belong_to :child
  should_belong_to :social_worker
end
