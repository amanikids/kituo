require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ChronicExtensionsTest < ActiveSupport::TestCase
  context '.parse' do
    setup do
      @sep_17 = Date.new(2009, 9, 17).to_time
    end

    should 'recognize "Second day this month"' do
      actual = Chronic.parse("Second day this month", :now => @sep_17)
      actual.to_date.should == Date.new(2009, 9, 2)
    end

    should 'recognize "the second day of this month"' do
      actual = Chronic.parse("the second day of this month", :now => @sep_17)
      actual.to_date.should == Date.new(2009, 9, 2)
    end

    should 'recognize "Third day this month"' do
      actual = Chronic.parse("Third day this month", :now => @sep_17)
      actual.to_date.should == Date.new(2009, 9, 3)
    end

    should 'recognize "the third day of this month"' do
      actual = Chronic.parse("the third day of this month", :now => @sep_17)
      actual.to_date.should == Date.new(2009, 9, 3)
    end
  end
end
