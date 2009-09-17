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

      ScheduledVisit.last.child.home_visits.make
    end

    desc 'Copy the production database down locally.'
    task :production => [:environment, :development_only, 'db:drop', 'db:create'] do
      system "ssh deploy@mchungaji 'mysqldump -u root kituo_production' | mysql -u root kituo_development"
      # FileUtils.rm_rf(Rails.root.join('public', 'system'))
      # system "scp -r deploy@mchungaji:/var/www/apps/kituo_production/shared/system #{Rails.root.join('public')}"
    end
  end
end
