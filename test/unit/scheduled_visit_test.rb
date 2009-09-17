require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ScheduledVisitTest < ActiveSupport::TestCase
  context '.before' do
    should 'return all scheduled visits before a given date inclusive, ordered by date' do
      expected = [
        ScheduledVisit.make(:scheduled_for => 2.days.from_now),
        ScheduledVisit.make(:scheduled_for => 2.days.ago)
      ].reverse
      chaff = ScheduledVisit.make(:scheduled_for => 3.days.from_now)

      ScheduledVisit.before(2.days.from_now).should == expected
    end
  end
end
