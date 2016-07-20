namespace :rails do
  desc "Remote console"
  task :console, :role => :app do
    run_interactively "bundle exec rails console #{rails_env}"
  end
end
