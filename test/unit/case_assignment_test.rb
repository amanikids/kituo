require File.join(File.dirname(__FILE__), '..', 'test_helper')

class CaseAssignmentTest < ActiveSupport::TestCase
  should_belong_to :child
  should_belong_to :social_worker

  should_validate_presence_of :social_worker_id
end
