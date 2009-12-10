namespace :app do
  desc "Reset each child's potential_duplicate flag"
  task :reset_duplicate_flags => :environment do
    Child.update_all(:potential_duplicate => true)
  end
end
