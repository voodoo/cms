set :application, "cms"
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }
set :rbenv_ruby, "2.2.1"
# set :stages, %w(production staging)
#set :default_stage, "staging"
#require 'capistrano/ext/multistage'

#set :deploy_via, :remote_cache #set :deploy_via, :remote_cache
#set :rails_env, 'production'
#set :use_sudo, false
#set :scm, "git"

#role :all, %w{deploy@server.com}

set :deploy_via, :remote_cache
set :deploy_to, "/home/mblz/apps/cms"
set :keep_releases, 5
set :repo_url, 'git@github.com:mblz/cms.git'
#set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || "master"
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :ssh_options, { :forward_agent => true }

#after "deploy", "deploy:cleanup" # keep only the last 5 releases

set :linked_files, %w{config/database.yml config/secrets.yml}

set :linked_dirs, %w{bin log tmp vendor/bundle public/system}

set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}
set :conditionally_migrate, true           # Defaults to false. If true, it's skip migration if files in db/migrate not modified

set :assets_roles, [:app]            # Defaults to [:web]
namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end
  after :publishing, :restart
  after :finishing, :cleanup

end

# after 'deploy:publishing', 'deploy:restart'
# after 'deploy:finishing', 'deploy:cleanup'

  #after "deploy:finalize_update", "deploy:symlink_config"

  # desc "Make sure local git is in sync with remote."
  # task :check_revision, roles: :web do
  #   unless `git rev-parse HEAD` == `git rev-parse origin/master`
  #     puts "WARNING: HEAD is not the same as origin/master"
  #     puts "Run `git push` to sync changes."
  #     exit
  #   end
  # end
  # before "deploy", "deploy:check_revision"


  # task :symlink_config do
  #   on roles(:app) do
  #     run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  #   end

  #   #run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  #  # run "ln -nfs /home/#{user}/assets/#{application}/uploads #{release_path}/public/system/uploads"
  #   #run "ln -nfs /Volumes/Files/assets #{release_path}/public/static"
  # end

#server "mmcolo.macminicolo.net", :web, :app, :db, primary: true
#set :deploy_via, :remote_cache
#set :deploy_via, :copy



# # config valid only for current version of Capistrano
# lock '3.3.5'

# set :application, 'my_app_name'
# set :repo_url, 'git@example.com:me/my_repo.git'

# # Default branch is :master
# # ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# # Default deploy_to directory is /var/www/my_app_name
# # set :deploy_to, '/var/www/my_app_name'

# # Default value for :scm is :git
# # set :scm, :git

# # Default value for :format is :pretty
# # set :format, :pretty

# # Default value for :log_level is :debug
# # set :log_level, :debug

# # Default value for :pty is false
# # set :pty, true

# # Default value for :linked_files is []
# # set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# # Default value for linked_dirs is []
# # set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# # Default value for default_env is {}
# # set :default_env, { path: "/opt/ruby/bin:$PATH" }

# # Default value for keep_releases is 5
# # set :keep_releases, 5

# namespace :deploy do

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

# end
