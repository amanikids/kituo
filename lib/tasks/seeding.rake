task :development_only do
  raise 'only in development' unless Rails.env.development?
end

namespace :db do
  namespace :seed do

    desc "Setup scheduled and recommend visits for development. Destroys existing data."
    task :random => [:environment, :development_only] do
      require 'faker'
      require 'machinist/active_record'
      require 'test/blueprints'

      [Caregiver, ScheduledVisit, Child].each(&:delete_all)

      headshot_path = "db/seed/images"
      headshots = Dir.new(headshot_path).entries.select {|x| x =~ /\.jpg$/i }
      headshots.collect! {|x| File.open("#{headshot_path}/#{x}") }

      user = Caregiver.make(:headshot => headshots.delete(headshots.rand), :role => 'social_worker')
      joe  = Caregiver.make(:headshot => headshots.delete(headshots.rand), :role => 'development_officer', :name => 'Joe Ventura')

      [
        -4.days, # Overdue visit
        0.days,  # Non-standard visit
        2.days,
        2.days,
        3.days,
        1.week + 1.day
      ].each do |day|
        child = user.children.make(
          :headshot                    => (rand < 0.8) ? headshots.delete(headshots.rand) : nil,
          :ignore_potential_duplicates => true
        )
        ScheduledVisit.make(
          :child         => child,
          :scheduled_for => Date.today.beginning_of_week + day)
        child.arrivals.make(:happened_on => 4.weeks.ago)
        child.home_visits.make(:happened_on => 3.week.ago)
        child.home_visits.make(:happened_on => 2.week.ago)
        child.reunifications.make(:happened_on => 2.weeks.ago)
        child.home_visits.make(:happened_on => 1.week.ago)
      end

      ScheduledVisit.last.child.home_visits.make

      5.times do
        user.children.make(
          :state                       => 'on_site', # No visits, recommended
          :headshot                    => headshots.delete(headshots.rand),
          :ignore_potential_duplicates => true)
      end
    end

    desc 'Copy the production database down locally.'
    task :production => [:environment, :development_only, 'db:drop', 'db:create'] do
      def mysql_options
        cmd = " -u #{db_credentials[:username]} "
        cmd += " -p'#{db_credentials[:password]}'" unless db_credentials[:password].nil?
        cmd += " #{db_credentials[:database]}"
      end

      def db_credentials
        ActiveRecord::Base.connection.instance_eval { @config } # Dodgy!
      end

      system "ssh deploy@mchungaji 'mysqldump -u root kituo_production' | mysql #{mysql_options}"
      FileUtils.rm_rf(Rails.root.join('public', 'system'))
      system "scp -r deploy@mchungaji:/var/www/apps/kituo_production/shared/system #{Rails.root.join('public')}"
    end
  end
end
