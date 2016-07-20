Capistrano::Configuration.instance(:must_exist).load do
  namespace :rails do
    desc "Open the rails console on one of the remote servers"
    task :console, :roles => :app do
      hostname = find_servers_for_task(current_task).first
      exec "ssh -l #{user} #{hostname} -t 'source ~/.profile && #{current_path}/script/rails c #{rails_env}'"
    end
  end
end
