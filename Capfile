load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
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

after 'deploy:finalize_update' do
  run "ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml"
end

after 'deploy', 'deploy:notify'

task :production do
  set :rails_env, 'production'
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

  task :notify do
    require File.join('lib', 'deploy_notifier')
    # notifier = DeployNotifier.new('Joe Ventura', 'Japhary Salum')
    notifier = DeployNotifier.new('Jennifer Hicks')

    url = case rails_env
    when 'staging'
      'http://kituo-mazoezi.amani'
    when 'production'
      'http://kituo.amani'
    end

    changes = `git log --pretty=format:'* %s' #{previous_revision}..`
    notifier.spam(<<-END.gsub(/^      /, ''))

      Just deployed to
      #{url}

      #{changes}
    END
  end
end
