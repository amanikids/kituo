load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

task :production do
  set :rails_env, 'production'
end

after 'deploy:setup' do
  database_config = {
    rails_env => {
      'adapter' => 'mysql',
      'encoding' => 'utf8',
      'database' => "kituo_#{rails_env}",
      'username' => 'root',
      'password' => '',
      'socket' => '/var/run/mysqld/mysqld.sock'
    }
  }
  put database_config.to_yaml, "#{shared_path}/database.yml"
end

after 'deploy:finalize_update' do
  run "ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml"
end

after 'deploy:update_code' do
  unless rails_env == 'production'
    run "mysqladmin drop --force kituo_#{rails_env}; mysqladmin create kituo_#{rails_env}; mysqldump --opt kituo_production | mysql kituo_#{rails_env}"
  end
end

namespace :deploy do
  desc 'Start the Application'
  task :start do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task(:stop) { }

  desc 'Restart the Application'
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
