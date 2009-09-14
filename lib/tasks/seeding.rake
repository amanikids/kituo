require 'net/ssh'

directory 'db/seed/images'

file 'db/seed/children.yml' => 'db/seed' do
  Net::SSH.start('amanikids', 'deploy') do |ssh|
    File.open('db/seed/children.yml', 'w') do |file|
      file.write ssh.exec!('cd website/current; RAILS_ENV=production rake --silent db:children')
    end
  end
end

namespace :db do
  task :seed => ['db/seed/children.yml', 'db/seed/images']
end
