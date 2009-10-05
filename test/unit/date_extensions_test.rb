require File.join(File.dirname(__FILE__), '..', 'test_helper')

class DateExtensionsTest < ActiveSupport::TestCase
  context '#at_beginning_of_financial_year' do
    should 'be October 1st of last year if self is before October' do
      Date.new(2009, 9, 30).at_beginning_of_financial_year.should == Date.new(2008, 10, 1)
    end

    should 'be October 1st of this year if self is on or after October 1st' do
      Date.new(2009, 10, 1).at_beginning_of_financial_year.should == Date.new(2009, 10, 1)
    end
  end
end
