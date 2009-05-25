xml.instruct!(:xml, :standalone => 'no')
xml.instruct!('xml-stylesheet', :type => 'text/css', :href => stylesheet_path('graphs'))
xml.declare!(:DOCTYPE, :svg, :PUBLIC, '-//W3C//DTD SVG 1.1//EN', 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd')
xml.svg(:version => '1.1', :xmlns => 'http://www.w3.org/2000/svg') do
  xml << yield
end
