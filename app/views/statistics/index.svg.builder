# what can we do here?
# . play with auto-scaling the graph: use a different chunk size if it's too "gappy"
# . learn how to show elements on hover

data           = Child.with(Arrival).map { |child| Date.today - child.arrivals.first.happened_on }
width          = 400
height         = 200
number_of_bars = 12

def period(days, days_per_period)
  (days / days_per_period).to_i
end

bars               = data.group_by { |days| period(days, data.max.to_f / number_of_bars) }
tallest_bar        = bars.values.map(&:length).max
width_of_one_bar   = width / (number_of_bars + 1)
height_of_one_unit = height / tallest_bar

xml.instruct!(:xml, :standalone => 'no')
xml.instruct!('xml-stylesheet', :type => 'text/css', :href => stylesheet_path('graphs'))
xml.declare!(:DOCTYPE, :svg, :PUBLIC, '-//W3C//DTD SVG 1.1//EN', 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd')
xml.svg(:width => width, :height => height, :version => '1.1', :xmlns => 'http://www.w3.org/2000/svg') do
  bars.each do |value, entries|
    xml.rect(
      :x => value * width_of_one_bar,
      :y => height - (entries.length * height_of_one_unit),
      :width => width_of_one_bar,
      :height => entries.length * height_of_one_unit
    )
  end
end