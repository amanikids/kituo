require 'test_helper'

class CaregiverTest < ActiveSupport::TestCase
  should_have_attached_file :headshot
  should_validate_presence_of :name
end
