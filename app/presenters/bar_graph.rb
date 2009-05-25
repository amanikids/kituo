class BarGraph
  def initialize(data, number_of_bars)
    @data           = data.dup.compact
    @number_of_bars = number_of_bars

    @width          = 400
    @height         = 200
    @label_height   = 16
    @label_interval = 2
  end

  class Bar < Struct.new(:x, :y, :width, :height, :value, :label, :label_height, :show_label)
    def centered_x
      x + (width / 2)
    end
  end

  def bars
    bars = []
    partitions.each_with_index do |value, index|
      x          = index * width_of_one_bar
      height     = value * height_of_one_unit
      y          = height_for_bars - height
      show_label = index.succ % @label_interval == 0

      bars << Bar.new(x, y, width_of_one_bar, height, value, label_for(index), @label_height, show_label)
    end
    bars
  end

  private

  def height_for_bars
    @height - @label_height
  end

  def height_of_one_unit
    return 0 if partitions.max.zero?
    height_for_bars / partitions.max
  end

  def label_for(index)
    return index if @data.min.nil?
    @data.min + (index.succ * partition_size)
  end

  def partitions
    Array.new(@number_of_bars, 0).tap do |partitions|
      @data.each do |value|
        partitions[partition_index_for(value)] += 1
      end
    end
  end

  def partition_index_for(value)
    (value - @data.min).quo(partition_size).floor
  end

  def partition_size
    return 0 if @data.max.nil?
    (@data.max - @data.min).quo(@number_of_bars).ceil
  end

  def width_of_one_bar
    @width / @number_of_bars
  end
end