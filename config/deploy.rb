# config valid only for current version of Capistrano
lock '3.6.1'

set :application, ENV['APP_NAME']
set :repo_url, ENV['REPO_URL']

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :scm, :git
set :branch, fetch(:branch, 'master')
# Default deploy_to directory is /var/www/my_app_name

# set :deploy_to, '/var/www/my_app_name'
set :deploy_to, ENV['DEPLOY_TO']
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
set :format, :airbrussh

### How Many old rlease do we want to keep ----
set :keep_release, 5

###
##
#
### Set Linked Files ----
##
#
# set :linked_files, fetch(:linked_files, []).push('config/unicorn.rb')
# set :unicron_file_path, 'config/unicorn.rb'

### You can configure the Airbrussh format using :format_options.
# These are the defaults.
# create log file for every release

Dir.mkdir("log/#{ENV['HOSTS']}") unless File.exists?("log/#{ENV['HOSTS']}")

set :format_options, command_output: true, log_file: "log/#{ENV['HOSTS']}/#{I18n.l(Time.now, format: "%Y%m%d%H%M%S")}.log", color: :auto, truncate: :auto
after :deploy, :restart
task :restart do
	on roles(:app), in: :sequence, wait: 5 do
	  execute "sudo /etc/init.d/apache2 restart"
	end
end
