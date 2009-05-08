require 'net/ssh'
require 'open-uri'

directory 'db/seed'

file 'db/seed/config.yml' => 'db/seed' do
  Net::SSH.start('amanikids', 'deploy') do |ssh|
    File.open('db/seed/config.yml', 'w') do |file|
      file.write ssh.exec!('cd website/current; RAILS_ENV=production rake --silent db:children')
    end
  end
end

namespace :db do
  task :seed => [:environment, 'db/seed/config.yml'] do
    YAML.load_file('db/seed/config.yml').each do |child|
      attributes = {}
      attributes[:name] = child[:name].strip
      attributes[:ignore_potential_duplicates] = true

      if child[:url]
        local_filename = "db/seed/#{File.basename(child[:url], '?*')}"
        unless File.exists?(local_filename)
          puts "fetching photo for #{child[:name]}..."
          File.open(local_filename, 'w') { |file| file.write open("http://amanikids.org#{child[:url]}").read }
        end
        attributes[:headshot] = File.open(local_filename)
      end

      if attributes[:name] =~ /\band\b/
        puts "Please split these kids up into separate lines, followed by a blank line:"
        puts attributes[:name]
        until((name = $stdin.gets).blank?)
          Child.create!(attributes.merge(:name => name.strip))
        end
      else
        Child.create!(attributes)
      end
    end
  end
end
