require File.join(File.dirname(__FILE__), '..', 'test_helper')

class DashboardHelperTest < ActiveSupport::TestCase
  include DashboardHelper

  context '#comment_for' do
    context 'a visit for a child with no previous visit' do
      should 'return a localized "Never visited"' do
        visit = ScheduledVisit.make
        comment_for(visit).should == ['.never_visited']
      end
    end

    context 'a visit for a child with a previous visit' do
      should 'return a localized "Last visited" for the most recent visit' do
        date = Date.today - 4.days
        visit = ScheduledVisit.make
        visit.child.home_visits.make(:happened_on => date)
        visit.child.home_visits.make(:happened_on => Date.today - 5.days)

        comment_for(visit).should == ['.last_visited', {:date => date}]
      end
    end
  end

  context '#distance_of_time_in_weeks' do
    context 'for a day in 2 weeks ago' do
      should 'return a localized "2 weeks ago"' do
        distance_of_time_in_weeks(2.weeks.ago).should ==
          ['datetime.distance_of_time_in_words.x_weeks_ago', {:count => 2}]
      end
    end

    context 'for a day 1 week ago' do
      should 'return a localized "last week"' do
        distance_of_time_in_weeks(1.weeks.ago).should ==
          ['datetime.distance_of_time_in_words.x_weeks_ago', {:count => 1}]
      end
    end

    context 'for a day this week' do
      should 'return a localized "this week"' do
        distance_of_time_in_weeks(Date.today).should ==
          ['datetime.distance_of_time_in_words.x_weeks_from_now', {:count => 0}]
      end
    end

    context 'for a day next week' do
      should 'return a localized "next week"' do
        distance_of_time_in_weeks(1.week.from_now).should ==
          ['datetime.distance_of_time_in_words.x_weeks_from_now', {:count => 1}]
      end
    end

    context 'for a day >= 2 weeks from now' do
      should 'return a localized "2 weeks from now"' do
        distance_of_time_in_weeks(2.weeks.from_now).should ==
          ['datetime.distance_of_time_in_words.x_weeks_from_now', {:count => 2}]
      end
    end
  end
end
