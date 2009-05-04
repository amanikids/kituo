load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

task(:staging)    { set :rails_env, 'staging' }
task(:production) { set :rails_env, 'production' }

after 'deploy:setup' do
  environment = fetch(:rails_env, 'staging')

  database_config = {
    environment => {
      'adapter' => 'mysql',
      'encoding' => 'utf8',
      'database' => "kituo_#{environment}",
      'username' => 'root',
      'password' => '',
      'socket' => '/var/run/mysqld/mysqld.sock'
    }
  }

  put database_config.to_yaml, "#{shared_path}/database.yml"
end

after 'deploy:finalize_update' do
  run "rm -rf #{latest_release}/config/database.yml; ln -s #{shared_path}/database.yml #{latest_release}/config/database.yml"
end

namespace :deploy do
  desc 'Restart the Application'
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
