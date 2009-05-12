pdf.font 'Times-Roman'

pdf.text 'Children at Amani', :size => 24
pdf.text "Week of #{Date.today.at_beginning_of_week} through #{Date.today.at_end_of_week}", :size => 15
pdf.move_down 12

child_rows = @children.map { |child| [child.name, '', '', '', '', '', '', ''] }
blank_rows = Array.new(5, Array.new(8, ' '))

pdf.table child_rows + blank_rows,
  :headers => ['Name', 'M', 'T', 'W', 'T', 'F', 'S', 'S'],
  :row_colors => ['FFFFFF', 'EEEEFF'],
  :align => Hash.new(:center).merge(0 => :left),
  :column_widths => { 0 => 300, 1 => 30, 2 => 30, 3 => 30, 4 => 30, 5 => 30, 6 => 30, 7 => 30 }
