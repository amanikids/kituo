require File.join(File.dirname(__FILE__), '..', 'test_helper')

class BarGraphTest < ActiveSupport::TestCase
  context 'given a spread of 0 with all numbers congruent to the number of bars' do
    setup do
      @bar_graph = BarGraph.new([5, 5, 5], 5)
    end

    should 'have a partition_size of 1' do
      @bar_graph.send(:partition_size).should == 1
    end
  end

  context 'with no data' do
    setup do
      @bar_graph = BarGraph.new([])
    end

    should 'have a partition_size of 1' do
      @bar_graph.send(:partition_size).should == 1
    end
  end

  context 'with a massive data value larger than the number of pixels allocated' do
    setup do
      @bar_graph = BarGraph.new([0] * 5000)
    end

    should 'not have a maximum bar height of 0' do
      @bar_graph.bars.map(&:height).max.should_not == 0
    end
  end
end
