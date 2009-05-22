# what can we do here?
# . play with auto-scaling the graph: use a different chunk size if it's too "gappy"
# . learn how to show elements on hover

width          = 400
height         = 200
number_of_bars = 18

partitioned_data   = @statistic.partitioned(number_of_bars)
bars               = partitioned_data.data
width_of_one_bar   = width / number_of_bars
height_of_one_unit = height / bars.values.max

xml.instruct!(:xml, :standalone => 'no')
xml.instruct!('xml-stylesheet', :type => 'text/css', :href => stylesheet_path('graphs'))
xml.declare!(:DOCTYPE, :svg, :PUBLIC, '-//W3C//DTD SVG 1.1//EN', 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd')
xml.svg(:width => width, :height => height, :version => '1.1', :xmlns => 'http://www.w3.org/2000/svg') do
  bars.each do |key, value|
    xml.rect(
      :x => ((key / partitioned_data.partition_size) - 1) * width_of_one_bar,
      :y => height - (value * height_of_one_unit),
      :width => width_of_one_bar,
      :height => value * height_of_one_unit
    )
  end
end