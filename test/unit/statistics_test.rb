require File.join(File.dirname(__FILE__), '..', 'test_helper')

class StatisticsTest < ActiveSupport::TestCase
  context '#child_count' do
    should 'return the number of children with the given state' do
      2.times { Child.make(:state => 'on_site') }
      chaff = Child.make(:state => 'dropped_out')

      Statistics.new.child_count(:on_site).should == 2
    end
  end

  context '#reunification_count' do
    should 'count reunifications since the given date' do
      2.times { Reunification.make(:happened_on => 2.days.ago) }
      chaff = Reunification.make(:happened_on => 1.week.ago)

      Statistics.new.reunification_count_since(2.days.ago).should == 2
    end

    should 'not count reunifications since overridden by another event' do
      child = Child.make
      child.reunifications.make(:happened_on => 1.week.ago)
      child.dropouts.make(:happened_on => 2.days.ago)

      Statistics.new.reunification_count_since(1.week.ago).should == 0
    end

    should 'not count multiple reunifications for the same child' do
      child = Child.make
      child.reunifications.make(:happened_on => 1.week.ago)
      child.reunifications.make(:happened_on => 2.days.ago)

      Statistics.new.reunification_count_since(1.week.ago).should == 1
    end
  end
end
