bar_graph.bars.each do |bar|
  xml.g(:class => 'column') do
    xml.rect(:x => bar.x, :y => 0, :width => bar.width, :height => bar.y, :class => 'whitespace')
    xml.text(bar.value, :x => bar.centered_x, :y => bar.y - 2, 'text-anchor' => 'middle') unless bar.value.zero?
    xml.rect(:x => bar.x, :y => bar.y, :width => bar.width, :height => bar.height, :class => 'bar')
    xml.rect(:x => bar.x, :y => bar.y + bar.height, :width => bar.width, :height => bar.label_height, :class => 'label')
    xml.text(bar.label, :x => bar.centered_x, :y => bar.y + bar.height + bar.label_height, 'text-anchor' => 'middle') if bar.show_label
  end
end

# FIXME don't hardcode these x and y values
xml.text(t('statistics.bar_graph.mean',   :mean => bar_graph.mean), :x => 416, :y => 32)
xml.text(t('statistics.bar_graph.median', :median => bar_graph.median), :x => 416, :y => 48)
xml.text(t('statistics.bar_graph.mode',   :mode => bar_graph.mode.to_sentence), :x => 416, :y => 64)