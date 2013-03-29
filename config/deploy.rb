require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, 'PelesendCopyCopter'
set :repository,  'git://github.com/Pelesend/copycopter-server.git'
set :deploy_to, '/home/copycpt1/application'

set :stages, %w(production)
set :default_stage, 'production'
require 'capistrano/ext/multistage'

set :scm, :git
set :rvm_ruby_string, '1.9.3-head@global'
set :rvm_type, :system
set :use_sudo, false

set :default_environment, {
    'PATH'            => '/usr/share/ruby-rvm/gems/ruby-1.9.3-head@global/bin:$PATH',
    'GEM_HOME'        => '/usr/share/ruby-rvm/gems/ruby-1.9.3-head@global',
    'GEM_PATH'        => '/usr/share/ruby-rvm/gems/ruby-1.9.3-head@global',
    'BUNDLE_PATH'     => '/usr/share/ruby-rvm/gems/ruby-1.9.3-head@global',
    'SHELL'           => '/bin/bash'
}

# if you want to clean up old releases on each deploy uncomment this:
after 'deploy:update_code', 'deploy:migrate'
after 'deploy:restart', 'deploy:cleanup'
before 'deploy:assets:precompile', 'bundle:install'
before 'deploy:assets:precompile', :production_config

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

task :production_config, :roles => [:app, :db] do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end