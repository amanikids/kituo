require File.join(File.dirname(__FILE__), '..', 'test_helper')

class StatisticTest < ActiveSupport::TestCase
  context 'simple' do
    setup do
      @statistic = Statistic.count(%w(cow chicken goat dog pig albatross kiwi), :length)
    end

    should 'count objects by method' do
      assert_equal({ 3 => 3, 4 => 2, 7 => 1, 9 => 1 }, @statistic.data)
    end

    should 'partition itself into 1 group' do
      partitioned = @statistic.partitioned(1)
      assert_equal({ 9 => 7 }, partitioned.data)
      assert_equal 9, partitioned.partition_size
    end

    should 'partition itself into 2 groups' do
      partitioned = @statistic.partitioned(2)
      assert_equal({ 5 => 5, 10 => 2 }, partitioned.data)
      assert_equal 5, partitioned.partition_size
    end

    should 'partition itself into 4 groups' do
      partitioned = @statistic.partitioned(4)
      assert_equal({ 3 => 3, 6 => 2, 9 => 2, 12 => 0 }, partitioned.data)
      assert_equal 3, partitioned.partition_size
    end
  end

  should 'disregard nil values'

  should 'provide maximum value'


end
