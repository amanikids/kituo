require 'vendor/plugins/action_mailer_optional_tls/lib/smtp_tls'
require 'vendor/plugins/action_mailer_optional_tls/lib/action_mailer_tls'
require 'vendor/plugins/cap_gun/lib/cap_gun'

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
  :tls => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'amanikids.org',
  :authentication => :plain,
  :user_name => 'no-reply@amanikids.org',
  :password => File.read(File.join(File.dirname(__FILE__), 'cap_gun_password.txt')).strip
}

# define the options for the actual emails that go out -- :recipients is the only required option
set :cap_gun_email_envelope, {
  :recipients => %w[joe@amanikids.org japhary@amanikids.org matthew.todd@gmail.com],
  :from       => 'Deployment Notifier <no-reply@amanikids.org>'
}

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
end

after 'deploy:update_code' do
  run "ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml"

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
