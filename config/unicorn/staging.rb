# path
app_path = '/var/www/rails/code4startup'
app_shared_path = "#{app_path}/shared"
working_directory "#{app_path}/current"

pid "#{app_shared_path}/tmp/pids/unicorn.pid"

# listen
listen "#{app_shared_path}/tmp/sockets/unicorn.sock"

# logging
stdout_path "#{app_shared_path}/log/unicorn.stdout.log"
stderr_path "#{app_shared_path}/log/unicorn.stderr.log"

# workers
worker_processes 2
timeout 60
preload_app true

# before starting processes
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

# after finishing processes
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end