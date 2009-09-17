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

namespace :kituo do
  desc "Setup scheduled and recommend visits for development. Destroys existing data."
  task :dev_data => :environment do
    raise 'only in development' unless Rails.env.development?

    require 'faker'
    require 'machinist/active_record'
    require 'test/blueprints'

    [Caregiver, ScheduledVisit, Child].each(&:delete_all)

    headshot_path = "db/seed/images"
    headshots = Dir.new(headshot_path).entries.select {|x| x =~ /\.jpg$/i }
    headshots.collect! {|x| File.open("#{headshot_path}/#{x}") }

    user = Caregiver.make(:headshot => headshots.delete(headshots.rand))

    [
      -4.days, # Overdue visit
      0.days,  # Non-standard visit
      2.days,
      2.days,
      3.days,
      1.week + 1.day
    ].each do |day|
      child = user.children.make(
        :headshot                    => headshots.delete(headshots.rand),
        :ignore_potential_duplicates => true
      )
      ScheduledVisit.make(
        :child         => child,
        :scheduled_for => Date.today.beginning_of_week + day)
    end
  end
end
