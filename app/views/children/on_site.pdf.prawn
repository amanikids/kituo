pdf.font 'Times-Roman'

pdf.text t('.title'), :size => 24
pdf.text t('.subtitle', :begin_date => Date.today.at_beginning_of_week, :end_date => Date.today.at_end_of_week), :size => 15
pdf.move_down 12

header_row = [Child.human_attribute_name('name')] + t('date.abbr_day_names')[1..-1] + [t('date.abbr_day_names')[0]]
child_rows = @children.map { |child| [child.name, '', '', '', '', '', '', ''] }
blank_rows = Array.new(5, Array.new(8, ' '))

pdf.table [header_row] + child_rows + blank_rows,
  :cell_style => {},
  :header => true,
  :column_widths => { 0 => 240, 1 => 40, 2 => 40, 3 => 40, 4 => 40, 5 => 40, 6 => 40, 7 => 40 } do |t|

  t.cells.style do |c|
    c.align = c.column.zero? ? :left : :center
    c.background_color = c.row.even? ? 'FFFFFF' : 'EEEEFF'
  end
end
