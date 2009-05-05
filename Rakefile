# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

namespace :db do
  task :seed => :environment do
    names = Rails.root.join('test', 'unit', 'name_matcher_test.rb').read.split('__END__').last.strip.split("\n")
    names.each do |name|
      Child.create!(:name => name, :ignore_potential_duplicates => true)
    end
  end
end