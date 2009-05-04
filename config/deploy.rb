set :application, 'kituo'
set :repository,  'git://github.com/amanikids/kituo.git'
set :user, 'deploy'
set :use_sudo, false

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :deploy_via, :remote_cache
set :git_enable_submodules, true

server ENV['HOST'], :web, :app, :db, :primary => true
