require 'tempfile'

When /^I dump the response$/ do
  Tempfile.open(['response', '.html']) do |file|
    file.write(response.body)
    file.flush
    system "open #{file.path}"
    sleep 5
  end
end

When /^I dump the database$/ do
  Tempfile.open(['database', '.txt']) do |file|
    file.write(Caregiver.all.map(&:attributes).to_yaml)
    file.write(CaseAssignment.all.map(&:attributes).to_yaml)
    file.write(Child.all.map(&:attributes).to_yaml)
    file.write(Event.all.map(&:attributes).to_yaml)
    file.flush
    system "open #{file.path}"
    sleep 5
  end
end