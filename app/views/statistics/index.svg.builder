width  = 400
height = 200

xml.instruct!(:xml, :standalone => 'no')
xml.instruct!('xml-stylesheet', :type => 'text/css', :href => stylesheet_path('graphs'))
xml.declare!(:DOCTYPE, :svg, :PUBLIC, '-//W3C//DTD SVG 1.1//EN', 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd')
xml.svg(:width => width, :height => height, :version => '1.1', :xmlns => 'http://www.w3.org/2000/svg') do

  bars               = Child.all.group_by { |child| child.name.length }
  number_of_columns  = bars.keys.max
  max                = bars.values.map(&:length).max

  width_of_one_bar   = width / number_of_columns
  height_of_one_unit = height / max

  bars.each do |value, children|
    xml.rect(
      :x => (value - 1) * width_of_one_bar,
      :y => height - (children.length * height_of_one_unit),
      :width => width_of_one_bar,
      :height => children.length * height_of_one_unit
    )
  end

end