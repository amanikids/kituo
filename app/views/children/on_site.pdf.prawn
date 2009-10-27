pdf.font 'Times-Roman'

pdf.text t('.title'), :size => 24
pdf.text t('.subtitle', :begin_date => Date.today.at_beginning_of_week, :end_date => Date.today.at_end_of_week), :size => 15
pdf.move_down 12

child_rows = @children.map { |child| [child.name, '', '', '', '', '', '', ''] }
blank_rows = Array.new(5, Array.new(8, ' '))

pdf.table child_rows + blank_rows,
  :headers => [Child.human_attribute_name('name')] + t('date.abbr_day_names')[1..-1] + [t('date.abbr_day_names')[0]],
  :row_colors => ['FFFFFF', 'EEEEFF'],
  :align => Hash.new(:center).merge(0 => :left),
  :column_widths => { 0 => 240, 1 => 40, 2 => 40, 3 => 40, 4 => 40, 5 => 40, 6 => 40, 7 => 40 }
