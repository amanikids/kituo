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

  # TODO Finish these off
  context '#recommended_visits for children with no scheduled visits' do
    setup do
      @social_worker = Caregiver.make

      already_scheduled = @social_worker.children.make
      already_scheduled.arrivals.make
      already_scheduled.scheduled_visits.make
    end

    should 'include a child that has arrived and not had a visit' do
      arrived = @social_worker.children.make
      arrived.arrivals.make

      not_arrived = @social_worker.children.make

      already_visited = @social_worker.children.make
      already_visited.arrivals.make
      already_visited.home_visits.make

      @social_worker.recommended_visits.map(&:child).should == [arrived]
    end

    should 'include a child that has arrived and has not had a visit in more than 1 month' do
      last_visited_over_a_month_ago = @social_worker.children.make
      last_visited_over_a_month_ago.arrivals.make
      last_visited_over_a_month_ago.home_visits.make(:happened_on => (1.month + 1.day).ago)

      chaff = @social_worker.children.make
      chaff.arrivals.make
      chaff.home_visits.make(:happened_on => 1.month.ago)

      @social_worker.recommended_visits.map(&:child).should == [last_visited_over_a_month_ago]
    end

    should 'include a child that is offsite boarding and it is the start of the school term'
    should 'include a child that is reunified and it is more than 3 months since their last visit'
  end
end
