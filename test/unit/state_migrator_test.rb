require File.join(File.dirname(__FILE__), '..', 'test_helper')

class StateMigratorTest < ActiveSupport::TestCase
  def self.should_have_state(state)
    should "have state '#{state}'" do
      migrate
      @child.reload.state.should == state
    end
  end

  def setup
    @child = Child.make
  end

  def migrate
    StateMigrator.new.migrate!
  end

  context 'a child with no events' do
    should_have_state('unknown')
  end

  context 'a child with an arrival' do
    setup do
      @child.arrivals.make
    end

    should_have_state 'on_site'

    should 'not have any new arrival events' do
      migrate
      @child.arrivals.count.should == 1
    end
  end

  context 'a child with an arrival followed by a home visit' do
    setup do
      @child.arrivals.make(:happened_on => 1.week.ago)
      @child.home_visits.make(:happened_on => 2.days.ago)
    end

    should_have_state 'on_site'
  end

  context 'a child with two events on the same day' do
    setup do
      @child.arrivals.make(:happened_on => 1.week.ago, :created_at => 3.seconds.ago)
      @child.dropouts.make(:happened_on => 1.week.ago, :created_at => 2.seconds.ago)
    end

    should_have_state 'dropped_out'
  end

end
