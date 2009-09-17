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
  namespace :features do
    desc "Run all cucumber features"
    task :all

    YAML.load(File.open("cucumber.yml")).keys.each do |profile|
      Cucumber::Rake::Task.new(profile, "Run #{profile} features") do |t|
        t.profile = profile
        t.cucumber_opts = "--tags ~@wip"
      end

      namespace profile do
        Cucumber::Rake::Task.new(:wip, "Show WIP #{profile} features") do |t|
          t.profile = profile
          t.cucumber_opts = "--tags @wip --dry-run"
        end
      end

      task profile => 'db:test:prepare'
      task :all => profile
    end
  end

  remove_task :default
  task :default => ['test:units', 'features:all', 'test:locales']
rescue LoadError
  puts "If you'd like to run the features, please install cucumber."
end
