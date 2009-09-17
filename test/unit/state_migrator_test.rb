require File.join(File.dirname(__FILE__), '..', 'test_helper')

class StateMigratorTest < ActiveSupport::TestCase
  def self.should_have_state(state)
    should "have state '#{state}'" do
      StateMigrator.new.migrate!
      @child.reload.state.should == state
    end
  end

  def setup
    @child = Child.make
    Child.update_all(['state = ?', ''], ['id = ?', @child.id])
    @child.reload
  end

  context 'a child with no events' do
    should_have_state('unknown')
  end

  context 'a child with an arrival' do
    setup do
      @child.arrivals.make
    end

    should_have_state 'on_site'
  end

  context 'a child with an unknown event' do
    should 'raise' do
      class AnUnknownEvent < Event
      end

      event = AnUnknownEvent.new
      event.child = @child
      event.save!

      lambda {
        StateMigrator.new.migrate!
      }.should raise_error
    end
  end

  context 'a child with an arrival followed by a home visit' do
    setup do
      @child.arrivals.make(:happened_on => 1.week.ago)
      @child.home_visits.make(:happened_on => 2.days.ago)
    end

    should_have_state 'on_site'
  end

end
