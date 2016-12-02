# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'qa_thinknetika_app'
set :repo_url, 'git@github.com:arthurkulchenko/qna_think.git'
set :deploy_to, '/home/thinknetika/qa_thinknetika_app'
set :deploy_user, "thinknetika"
# set :format, :airbrussh
set :format, :pretty
# set :log_level, :debug
# set :bundle_flags, '--verbose'
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: false
append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundler'
# set :linked_files, %w(config/database.yml config/secrets.yml)
# set :linked_dirs %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundler public/system)
set :keep_releases, 3

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  # COMMANDS = %w(start stop restart)

  # COMMANDS.each do |command|
  #   task command do
  #     on roles(:app), in: :sequence, wait: 5 do
  #       within current_path do
  #         execute :bundle, "exec thin #{command} -C config/thin.yml"
  #       end
  #     end
  #   end
  # end
  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end
end
namespace :puma do
  task :start, :except => { :no_release => true } do
    run "/etc/init.d/puma start #{application}"
  end
  after "deploy:start", "puma:start"
  task :stop, :except => { :no_release => true } do
    run "/etc/init.d/puma stop #{application}"
  end
  after "deploy:stop", "puma:stop"
  task :restart, roles: :app do
    run "/etc/init.d/puma restart #{application}"
  end
  after "deploy:restart", "puma:restart"
end
