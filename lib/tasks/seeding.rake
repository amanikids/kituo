require 'csv'
require 'highline'
require 'net/ssh'
require 'open-uri'

directory 'db/seed/images'

file 'db/seed/children.yml' => 'db/seed' do
  Net::SSH.start('amanikids', 'deploy') do |ssh|
    File.open('db/seed/children.yml', 'w') do |file|
      file.write ssh.exec!('cd website/current; RAILS_ENV=production rake --silent db:children')
    end
  end
end

namespace :db do
  task :seed => [:environment, 'db/seed/children.yml', 'db/seed/images'] do
    YAML.load_file('db/seed/children.yml').sort_by { |child| child[:name] }.each do |child|
      attributes = {}
      attributes[:name] = child[:name].strip
      attributes[:ignore_potential_duplicates] = true

      if child[:url]
        local_filename = "db/seed/images/#{File.basename(child[:url], '?*')}"
        unless File.exists?(local_filename)
          puts "fetching photo for #{child[:name]}..."
          File.open(local_filename, 'w') { |file| file.write open("http://amanikids.org#{child[:url]}").read }
        end
        attributes[:headshot] = File.open(local_filename)
      end

      if attributes[:name] =~ /\band\b/
        names = ask("Please split up #{attributes[:name]} with commas:", lambda { |str| str.split(/,\s*/) })
        names.each { |name| Child.create!(attributes.merge(:name => name.strip)) }
      else
        Child.create!(attributes)
      end
    end

    CSV.open(Rails.root.join('db', 'seed', 'events.csv'), 'r') do |row|
      type, name, date = row

      if happened_on = parse_date(date)
        if child = find_child(name)
          child.send(type.tableize).create!(:happened_on => happened_on)
        end
      end
    end
  end
end

def find_child(name)
  if child = Child.find_by_name(name)
    return child
  end

  name = choose("Who is #{name}?") do |menu|
    menu.choices(*Child.search(name).map(&:name))
    menu.choice(nil)
  end

  Child.find_by_name(name)
end

def parse_date(date)
  year, month, day = date.to_s.scan(/(?:(\d{4})(?:-(\d{1,2})(?:-(\d{1,2}))?)?)?/).flatten.compact
  month ||= 1
  day   ||= 1
  Date.new(year.to_i, month.to_i, day.to_i) if year
end

def choose(question, &block)
  if answer_exists?(question)
    return lookup_answer(question)
  end

  HighLine.new.choose do |menu|
    menu.header = question
    block.call(menu)
  end.tap do |answer|
    store_answer(question, answer)
  end
end

def ask(question, conversion)
  if answer_exists?(question)
    return lookup_answer(question)
  end

  HighLine.new.ask(question, conversion).tap do |answer|
    store_answer(question, answer)
  end
end

def answer_exists?(question)
  @answers ||= (File.exists?('db/seed/answers.yml') ? YAML.load_file('db/seed/answers.yml') : {})
  @answers.has_key?(question)
end

def lookup_answer(question)
  @answers[question]
end

def store_answer(question, answer)
  @answers[question] = answer
  File.open('db/seed/answers.yml', 'w') { |file| file.write(@answers.to_yaml) }
end