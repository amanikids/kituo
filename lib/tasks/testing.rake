Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

def remove_task(task_name)
  Rake.application.remove_task(task_name)
end

remove_task :test
task :test => ['test:units', 'test:locales']

namespace :test do
  Rake::TestTask.new(:locales => 'db:test:prepare') do |t|
    t.libs << 'test'
    t.pattern = 'test/locale/**/*_test.rb'
    t.verbose = true
  end
  Rake::Task['test:locales'].comment = 'Run the locale tests in test/locale'
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features) { |t| t.cucumber_opts = '--format pretty --tags ~pending' }
  task :features => 'db:test:prepare'
  remove_task :default
  task :default => ['test:units', 'features', 'test:locales']
rescue LoadError
  puts "If you'd like to run the features, please install cucumber."
end