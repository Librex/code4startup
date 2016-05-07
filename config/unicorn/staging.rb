$worker  = 2
$timeout = 30
$app_dir = "/var/www/rails/code4startup/current"
$listen  = File.expand_path 'tmp/sockets/unicorn.sock', $app_dir
$pid     = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
$std_log = File.expand_path 'log/unicorn.log', $app_dir

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
worker_processes 5
timeout 60
preload_app true