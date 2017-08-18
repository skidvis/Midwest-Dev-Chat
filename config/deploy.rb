require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'    # for rvm support. (https://rvm.io)

set :application_name, 'MidwestDevChat'
set :domain, '104.131.182.163'
set :deploy_to, '/srv/app/midwestdevchat.com'
set :repository, 'https://github.com/skidvis/Midwest-Dev-Chat.git'
set :branch, 'master'
set :rvm_use_path, '/usr/local/rvm/bin/rvm'

set :user, 'sitedeploy'    # Username in the server to SSH to.
set :ssh_options, '-A'
set :forward_agent, true     # SSH forward_agent.

set :shared_dirs, fetch(:shared_dirs, []).push('log')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

task :environment do
  invoke :'rvm:use', 'ruby-2.2.0p0@default'
end

task :setup do
  # # command %{rbenv install 2.3.0}
  # command %[mkdir -p "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/log"]
  # command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/log"]

  # command %[mkdir -p "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/config"]
  # command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/config"]

  # command %[touch "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/config/database.yml"]
  # command  %[echo "-----> Be sure to edit '#{fetch(:deploy_to)}/#{fetch(:shared_path)}/config/database.yml'."]

  # command %[touch "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/config/secrets.yml"]
  # command  %[echo "-----> Be sure to edit '#{fetch(:deploy_to)}/#{fetch(:shared_path)}/config/secrets.yml'."]  
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
        command %{bundle exec rake slack:update_channels RAILS_ENV=production}
      end
    end
  end
end