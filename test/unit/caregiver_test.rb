require File.join(File.dirname(__FILE__), '..', 'test_helper')

class CaregiverTest < ActiveSupport::TestCase
  should_have_many :children

  should_have_attached_file :headshot
  should_validate_presence_of :name

  context '#friendly_name' do
    should 'return the first name' do
      user = Caregiver.make_unsaved(:name => 'Don T. Alias')
      assert_equal 'Don', user.friendly_name
    end
  end
end
