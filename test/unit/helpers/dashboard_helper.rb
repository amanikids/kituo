require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class Helpers::DashboardHelperTest < ActiveSupport::TestCase
  include DashboardHelper

  context '#distance_of_time_in_weeks' do
    context 'for a day in 2 weeks ago' do
      should 'return a localized "2 weeks ago"' do
        distance_of_time_in_weeks(2.weeks.ago).should == 
          ['datetime.distance_in_words.x_weeks_ago', {:count => 2}]
      end
    end

    context 'for a day 1 week ago' do
      should 'return a localized "last week"' do
        distance_of_time_in_weeks(1.weeks.ago).should == 
          ['datetime.distance_in_words.x_weeks_ago', {:count => 1}]
      end
    end

    context 'for a day this week' do
      should 'return a localized "this week"' do
        distance_of_time_in_weeks(Date.today).should == 
          ['datetime.distance_in_words.x_weeks_from_now', {:count => 0}]
      end
    end

    context 'for a day next week' do
      should 'return a localized "next week"' do
        distance_of_time_in_weeks(1.week.from_now).should == 
          ['datetime.distance_in_words.x_weeks_from_now', {:count => 1}]
      end
    end

    context 'for a day >= 2 weeks from now' do
      should 'return a localized "2 weeks from now"' do
        distance_of_time_in_weeks(2.weeks.from_now).should == 
          ['datetime.distance_in_words.x_weeks_from_now', {:count => 2}]
      end
    end
  end
end
