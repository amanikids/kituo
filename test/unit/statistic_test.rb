require File.join(File.dirname(__FILE__), '..', 'test_helper')

# 1.month.ago may be anywhere from 28 to 31 days, whereas 1.month is always 30.days
# 1.year.ago may be anywhere from 365 to 366 days, whereas 1.year is always 365.days
# So, it's safest to just use weeks in these tests.
class StatisticTest < ActiveSupport::TestCase
  context 'average stay' do
    setup { @statistics = Statistic.new }

    should 'be 0 with no children' do
      assert_equal 0, @statistics.average_stay
    end

    should 'be 0 with no arrivals' do
      Child.make
      assert_equal 0, @statistics.average_stay
    end

    should 'be the length of time since one child arrived' do
      child = Child.make
      child.arrivals.make(:happened_on => 14.weeks.ago)
      assert_equal 14.weeks, @statistics.average_stay
    end
  end
end
