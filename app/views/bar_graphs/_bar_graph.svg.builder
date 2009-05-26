bar_graph.bars.each do |bar|
  xml.g(:class => 'column') do
    xml.rect(:x => bar.x, :y => 0, :width => bar.width, :height => bar.y, :class => 'whitespace')
    xml.text(bar.value, :x => bar.centered_x, :y => bar.value_y, 'text-anchor' => 'middle') unless bar.value.zero?
    xml.rect(:x => bar.x, :y => bar.y, :width => bar.width, :height => bar.height, :class => 'bar')
    xml.rect(:x => bar.x, :y => bar.label_box_y, :width => bar.width, :height => bar.label_height, :class => 'label')
    xml.text(bar.label, :x => bar.centered_x, :y => bar.label_y, 'text-anchor' => 'middle') if bar.show_label
  end
end

xml.text(t('statistics.bar_graph.mean',   :mean => bar_graph.mean), :x => bar_graph.legend_x, :y => bar_graph.legend_y_row(0))
xml.text(t('statistics.bar_graph.median', :median => bar_graph.median), :x => bar_graph.legend_x, :y => bar_graph.legend_y_row(1))
xml.text(t('statistics.bar_graph.mode',   :mode => bar_graph.mode.to_sentence), :x => bar_graph.legend_x, :y => bar_graph.legend_y_row(2))