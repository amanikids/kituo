class BarGraph
  def initialize(data, number_of_bars=21)
    @data           = data.compact
    @number_of_bars = number_of_bars

    @width          = 400
    @height         = 200
    @label_height   = 16
    @label_interval = 3
  end

  class Bar < Struct.new(:x, :y, :width, :height, :value, :label, :label_height, :show_label)
    def centered_x
      x + (width / 2)
    end
  end

  def bars
    partitions.enum_for(:map).with_index do |value, index|
      x          = index * width_of_one_bar
      height     = value * height_of_one_unit
      y          = height_for_bars - height
      show_label = index.succ % @label_interval == 0

      Bar.new(x, y, width_of_one_bar, height, value, label_for(index), @label_height, show_label)
    end
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
    minimum_value + (index.succ * partition_size)
  end

  def maximum_value
    return nil if @data.max.nil?

    maximum_value = @data.max
    maximum_value += 1 until maximum_value % @number_of_bars == 0
    maximum_value
  end

  def minimum_value
    return nil if @data.min.nil?

    minimum_value = @data.min
    minimum_value -= 1 until minimum_value % @number_of_bars == 0
    minimum_value
  end

  def partitions
    Array.new(@number_of_bars, 0).tap do |partitions|
      @data.each do |value|
        partitions[partition_index_for(value)] += 1
      end
    end
  end

  def partition_index_for(value)
    (value - minimum_value).quo(partition_size).floor
  end

  def partition_size
    return 0 if maximum_value.nil?
    (maximum_value - minimum_value).quo(@number_of_bars).ceil
  end

  def width_of_one_bar
    @width / @number_of_bars
  end
end