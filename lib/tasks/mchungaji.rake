def start_and_wait_for(command)
  pid = fork do
    puts command
    exec "#{command} >/dev/null 2>&1"
  end

  sleep 5

  at_exit do
    Process.kill('INT', pid)
    Process.wait(pid, Process::WNOHANG)
  end
end

# In the mysql2 connection urls below, note that we have to say 127.0.0.1:3306,
# not localhost, else the mysql2 driver assumes it's okay to use
# /tmp/mysql.sock instead.
namespace :mchungaji do
  namespace :push do
    task :development do
      start_and_wait_for 'ssh -L 3306:localhost:3306 -N mchungaji'
      start_and_wait_for 'taps server -p 5000 postgres://localhost/kituo_development login password'
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      sh 'taps push mysql2://root@127.0.0.1:3306/kituo_production http://login:password@localhost:5000'
      sh 'rsync -rz --delete mchungaji:/var/www/apps/kituo_production/shared/system public'
    end
  end
end
