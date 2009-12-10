class BarGraph
  extend ActiveSupport::Memoizable

  def initialize(data, number_of_bars=21)
    @data           = data.compact
    @number_of_bars = number_of_bars

    @width          = 600
    @legend_width   = 200
    @height         = 200
    @label_height   = 16
    @label_interval = 3
  end

  class Bar < Struct.new(:x, :y, :width, :height, :value, :label, :label_height, :show_label)
    def centered_x
      x + (width / 2)
    end

    def label_box_y
      y + height
    end

    def label_y
      y + height + label_height
    end

    def value_y
      y - 2
    end
  end

  def bars
    partitions.enum_for(:map).with_index do |value, index|
      x          = index * width_of_one_bar
      height     = (value * height_of_one_unit).floor
      y          = @label_height + height_for_bars - height
      show_label = index.succ % @label_interval == 0

      Bar.new(x, y, width_of_one_bar, height, value, label_for(index), @label_height, show_label)
    end
  end

  def legend_x
    width_for_bars + @label_height
  end

  def legend_y_row(row)
    row.succ.succ * @label_height
  end

  def mean
    return 0 if @data.empty?
    @data.sum / @data.length
  end

  def median
    return 0 if @data.empty?
    @data.sort[@data.length / 2]
  end

  def mode
    return [0] if @data.empty?

    counter = Hash.new(0).tap do |counter|
      @data.each do |number|
        counter[number] += 1
      end
    end

    mode_value = counter.values.max
    counter.select { |k, v| v == mode_value }.map { |pair| pair.first }
  end

  private

  def height_for_bars
    @height - (2 * @label_height)
  end
  memoize :height_for_bars

  def height_of_one_unit
    return 0 if partitions.max.zero?
    height_for_bars.to_f / partitions.max
  end
  memoize :height_of_one_unit

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
  memoize :maximum_value

  def minimum_value
    return nil if @data.min.nil?

    minimum_value = @data.min
    minimum_value -= 1 until minimum_value % @number_of_bars == 0
    minimum_value
  end
  memoize :minimum_value

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
    return 1 if maximum_value.nil?
    [(maximum_value - minimum_value).quo(@number_of_bars).ceil, 1].max
  end
  memoize :partition_size

  def width_for_bars
    @width - @legend_width
  end
  memoize :width_for_bars

  def width_of_one_bar
    width_for_bars / @number_of_bars
  end
  memoize :width_of_one_bar
end