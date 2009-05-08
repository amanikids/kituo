pdf.font 'Times-Roman'

pdf.text 'Children at Amani', :size => 24
pdf.text "Week of #{Date.today.at_beginning_of_week} through #{Date.today.at_end_of_week}", :size => 15
pdf.move_down 12

if @children.any?
  pdf.table @children.map { |child| [child.name, '', '', '', '', '', '', ''] }, 
    :headers => ['Name', 'M', 'T', 'W', 'T', 'F', 'S', 'S'], 
    :row_colors => ['FFFFFF', 'EEEEFF'], 
    :align => { 0 => :left, 1 => :center, 2 => :center, 3 => :center, 4 => :center, 5 => :center, 6 => :center, 7 => :center }, 
    :column_widths => { 0 => 300, 1 => 30, 2 => 30, 3 => 30, 4 => 30, 5 => 30, 6 => 30, 7 => 30 }
end
