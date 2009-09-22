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

  context '#recommended_visits' do
    should 'honor the limit parameter' do
      social_worker = Caregiver.make
      2.times do
        social_worker.children.make(:state => 'on_site')
      end

      social_worker.recommended_visits.size.should == 2
      social_worker.recommended_visits(:limit => 1).size.should == 1
    end
  end
end
