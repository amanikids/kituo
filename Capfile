require 'vendor/plugins/action_mailer_optional_tls/lib/smtp_tls'
require 'vendor/plugins/action_mailer_optional_tls/lib/action_mailer_tls'
require 'vendor/plugins/cap_gun/lib/cap_gun'

load 'deploy'
load 'config/deploy'

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
  if rails_env == 'staging'
    # Replace our data with production data.
    run "mysqladmin --user root drop --force kituo_#{rails_env}"
    run "mysqladmin --user root create kituo_#{rails_env}"
    run "mysqldump  --user root --opt kituo_production | mysql --user root kituo_#{rails_env}"

    # Replace our system files (think Paperclip) with production system files.
    run "rm -rf #{shared_path}/system"
    run "cp -r  #{shared_path.gsub('staging', 'production')}/system #{shared_path}"
  end
end

after 'deploy:restart', 'cap_gun:email'

task :production do
  set :rails_env, 'production'
  set :domain, 'http://kituo.amani'
end

namespace :deploy do
  desc 'Deploy the app, running migrations.'
  task :default do
    migrations
  end

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
