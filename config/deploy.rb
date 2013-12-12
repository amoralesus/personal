require "bundler/capistrano"

set :application, "web"
set :repository,  "git@github.com:amoralesus/personal.git"
set :deploy_to, "/u/apps/personal"

set :scm, :git
set :branch, :master
set :use_sudo, false

set :user, "deploy"

set :rails_env, 'production'

set :deploy_via, :copy

#set :ssh_options, {:forward_agent => true, :port => 4321}

set :keep_releases, 5

default_run_options[:pty] = true

after "deploy:update_code", "deploy:migrate"

server "amorales.us", :app, :web, :db, :primary => true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

