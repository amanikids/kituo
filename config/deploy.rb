require 'cap_gun'

# =============================================================================
# = Settings                                                                  =
# =============================================================================
set :application, 'kituo'
set :repository,  '/var/www/apps/git/kituo.git'
set :local_repository,  'deploy@mchungaji.amani:git/kituo.git'
set :user, 'deploy'
set :use_sudo, false

# the 'production' task overrides these
set :rails_env, 'staging'
set :domain, 'http://kituo-mazoezi.amani'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set(:deploy_to) { "/var/www/apps/#{application}_#{rails_env}" }

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :deploy_via, :remote_cache
set :git_enable_submodules, true

server 'mchungaji.amani', :web, :app, :db, :primary => true

# setup action mailer with a hash of options
set :cap_gun_action_mailer_config, {
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'amanikids.org',
  :user_name => 'no-reply@amanikids.org',
  :password => File.read(File.join(File.dirname(__FILE__), 'cap_gun_password.txt')).strip,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# define the options for the actual emails that go out -- :recipients is the only required option
set :cap_gun_email_envelope, {
  :recipients => %w[fidea@amanikids.org matthew.todd@gmail.com],
  :from       => 'Deployment Notifier <no-reply@amanikids.org>'
}

# Be sure we use the bundled version of rake; this way, it doesn't matter what
# other versions are installed on the server.
set :rake, 'bundle exec rake'

# =============================================================================
# = Tasks                                                                     =
# =============================================================================
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

desc 'Run an arbitrary rake task. (-s task=foo)'
task :rake do
  rake      = fetch(:rake)
  rails_env = fetch(:rails_env)
  rake_task = fetch(:task)
  run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} #{rake_task}"
end

# =============================================================================
# = Callbacks                                                                 =
# =============================================================================
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
  run "mkdir -p #{shared_path}/bundle" # TODO should use shared_children instead.
end

after 'deploy:update_code' do
  run "ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml"
  run "ln -sf #{shared_path}/bundle #{latest_release}/vendor/bundle"

  run "cd #{latest_release} && bundle install --deployment --without development --without test"

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
