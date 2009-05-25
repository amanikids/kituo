class BarGraph
  attr_reader :partitioned_data

  def initialize(statistic, number_of_bars)
    @width = 400
    @height = 200
    @label_height = 16
    @height_for_bars = @height - @label_height
    @number_of_bars  = number_of_bars
    @label_interval  = 2

    @partitioned_data = statistic.partitioned(@number_of_bars)
    @width_of_one_bar = @width / @number_of_bars
    @height_of_one_unit = @height_for_bars / @partitioned_data.data.values.max
  end

  class Bar < Struct.new(:x, :y, :width, :height, :value, :label, :label_height, :show_label)
    def centered_x
      x + (width / 2)
    end
  end

  def bars
    @partitioned_data.data.map do |key, value|
      bar_number = key / @partitioned_data.partition_size

      x = (bar_number - 1) * @width_of_one_bar
      height = value * @height_of_one_unit
      y = @height_for_bars - height
      show_label = bar_number % @label_interval == 0

      Bar.new(x, y, @width_of_one_bar, height, value, key, @label_height, show_label)
    end
  end
end