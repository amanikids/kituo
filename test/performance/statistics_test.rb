require 'test_helper'
require 'performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class StatisticsTest < ActionController::PerformanceTest
  def test_length_of_stay
    get length_of_stay_statistics_path(:format => :svg)
  end
end
