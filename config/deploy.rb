# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'qa_thinknetika_app'
set :repo_url, 'git@github.com:arthurkulchenko/qna_think.git'
# set :deploy_to, '/home/thinknetika/qa_thinknetika_app'
# set :deploy_user, "thinknetika"
set :user, "thinknetika"
set :format, :pretty
set :pty, false
# set :pty, true
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: false
append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundler'
set :keep_releases, 3

set :puma_threads,    [4, 16]
set :puma_workers,    0

# set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord


# namespace :deploy do
#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end
# end
namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
# ----------------------
  desc 'INVOKERS COMMAND'
  task :invoke, :command do |task, args|
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, args[:command]
        end
      end
    end
  end
  # desc 'make ts:rebuild'
  # task :ts_rebuild do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     # execute "bundle exec rake ts:rebuild"
  #     invoke 'rake ts:rebuild'
  #     # invoke 'puma:restart'
  #   end
  # end
  # task :ts_rebuild, roles(:app) do
  #   # execute 'cd #{current_path}; rake ts:rebuild'
  # end
# ----------------------
  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end
