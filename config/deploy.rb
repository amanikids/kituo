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
  :user_name => 'deploy@amanikids.org',
  :password => File.read(File.join(File.dirname(__FILE__), 'cap_gun_password.txt')).strip
}

# define the options for the actual emails that go out -- :recipients is the only required option
set :cap_gun_email_envelope, {
  :recipients => %w[joe@amanikids.org japhary@amanikids.org matthew.todd@gmail.com],
  :from       => 'Deployment Notifier <deploy@amanikids.org>'
}
