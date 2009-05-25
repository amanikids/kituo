# what can we do here?
# . play with auto-scaling the graph: use a different chunk size if it's too "gappy"
# . learn how to show elements on hover

width           = 400
height          = 200
label_height    = 16
height_for_bars = height - label_height
number_of_bars  = 20
label_interval  = 2

partitioned_data   = @statistic.partitioned(number_of_bars)
bars               = partitioned_data.data
width_of_one_bar   = width / number_of_bars
height_of_one_unit = height_for_bars / bars.values.max

  bars.each do |key, value|
    bar_number = key / partitioned_data.partition_size
    x = (bar_number - 1) * width_of_one_bar
    height_of_this_bar = value * height_of_one_unit

    xml.g(:class => 'column') do
      xml.rect(
        :x => x,
        :y => 0,
        :width => width_of_one_bar,
        :height => height_for_bars - height_of_this_bar,
        :class => 'whitespace'
      )

      xml.text(value, :x => x + (width_of_one_bar / 2), :y => (height_for_bars - height_of_this_bar) - 2, 'text-anchor' => 'middle') unless value.zero?

      xml.rect(
        :x => x,
        :y => height_for_bars - height_of_this_bar,
        :width => width_of_one_bar,
        :height => height_of_this_bar,
        :class => 'bar'
      )

      xml.rect(
        :x => x,
        :y => height_for_bars,
        :width => width_of_one_bar,
        :height => label_height,
        :class => 'label'
      )
      xml.text(key, :x => x + (width_of_one_bar / 2), :y => height, 'text-anchor' => 'middle') if bar_number % label_interval == 0
    end
  end
