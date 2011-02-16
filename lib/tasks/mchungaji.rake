def start_and_wait_for(command)
  pid = fork do
    puts command
    exec command
  end

  sleep 5 # this could be smarter, looking for an open port

  at_exit do
    Process.kill('INT', pid)
  end
end

namespace :mchungaji do
  namespace :push do
    task :development do
      start_and_wait_for 'ssh -L 3306:mchungaji:3306 -N mchungaji'
      start_and_wait_for 'taps server -p 5000 postgres://localhost/kituo_development login password'
      sh 'rake db:drop db:create'
      sh 'taps push mysql://root@localhost/kituo_production http://login:password@localhost:5000'
      sh 'rsync -rz --delete mchungaji:/var/www/apps/kituo_production/shared/system public'
    end

    task :staging do
      start_and_wait_for 'ssh -L 3306:mchungaji:3306 -N mchungaji'
      sh 'heroku pg:reset --remote staging'
      sh 'heroku db:push mysql://root@localhost/kituo_production --remote staging'
    end

    task :production do
      start_and_wait_for 'ssh -L 3306:mchungaji:3306 -N mchungaji'
      sh 'heroku pg:reset --remote production'
      sh 'heroku db:push mysql://root@localhost/kituo_production --remote production'
    end
  end
end
