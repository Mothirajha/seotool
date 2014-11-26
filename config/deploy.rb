require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
#require 'mina/rvm'    # for rvm support. (http://rvm.io)
require 'mina_sidekiq/tasks'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)


set :term_mode, nil # fix for password prompt
set :domain, 'xxx.xx.xx.x' 
set :deploy_to, '/home/deployer/apps/seotool'
set :repository, 'https://github.com/Mothirajha/seotool.git'
set :branch, 'production'
set :rails_env, 'production'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', 'tmp']

# Optional settings:
   set :user, 'deployer'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.


# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-2.1.2@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
  queue! "sudo ln -nfs #{deploy_to}/current/config/unicorn_init.sh /etc/init.d/unicorn_seotool"
  queue! "sudo ln -nfs #{deploy_to}/current/config/nginx.conf /opt/nginx/conf/nginx.conf"

  # sidekiq needs a place to store its pid file and log file
  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids/"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    # invoke :'rewrite_cronjob'

    to :launch do
      queue "touch #{deploy_to}/tmp/restart.txt"
      invoke :'sidekiq:restart'
    end
  end

 
end


# desc "cron jon"
# task :initiate_whenever => :environment do
#   invoke :rewrite_cronjob 
# end

# desc "Write crontab whenever"
# task :rewrite_cronjob do
#   queue %{
#     echo "-----> Update crontab for #{current_path} #{release_path}"
#     #{echo_cmd %[cd #{deploy_to!}/current ; bundle exec whenever -c]}
#     #{echo_cmd %[cd #{deploy_to!}/current ; bundle exec whenever ]}
#     #{echo_cmd %[cd #{deploy_to!}/current ; bundle exec whenever -w  ]}
#   }
# end

# desc "Update the crontab file"
#   task :update_crontab do
#     queue! %[cd "#{deploy_to} && bundle exec whenever --update-crontab"]
#   end
