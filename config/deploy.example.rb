set :use_sudo, false

set :user, "YOUR USER NAME"
set :user_password, "YOUR PASSWORD"

set :application, "cms"
set :repository,  "."
set :domain, "cmessence.com"



# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/USER_NAME/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, "git"
#set :deploy_via, :copy
set :git_shallow_clone, 1

role :app, domain
role :web, domain
role :db,  domain, :primary => true


namespace :deploy do    
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end   
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
    
end