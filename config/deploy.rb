# config valid for current version and patch releases of Capistrano
lock "~> 3.18.1"

set :application, 'ps_store'
set :repo_url, 'git@github.com:eldar88e/ps_store.git'

# Default branch is :master
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp # 'main'

set :deploy_to, "/home/deploy/#{fetch :application}"
# set :linked_files, fetch(:linked_files, []).push('.env') # 'config/master.key'
# set :linked_dirs, fetch(:linked_dirs, []).push('log')

# set :stage, :production

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for linked_dirs is []
# append :linked_dirs, "tmp/pids", "tmp/cache", "tmp/sockets" # "storage", "vendor"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  current_path = "/home/deploy/ps_store/current"

  desc 'Copy .env to Docker container'
  task :start_copy_env do
    on roles(:app) do
      within '/home/deploy/ps_store' do
        execute "docker", "cp", "./.env", "store:/app"
      end
    end
  end

  desc 'Start docker-compose services'
  task :start_docker_services do
    on roles(:app) do
      within current_path do
        execute :docker, 'compose up --build -d'
      end
    end
  end

  desc 'Run Rails database migration'
  task :run_db_migration do
    on roles(:app) do
      within current_path do
        execute :docker, 'compose exec store bundle install'
        execute :docker, 'compose exec store rails db:migrate'
      end
    end
  end

  desc 'Stop old container and rails app'
  task :stop_old_container do
    on roles(:app) do
      within current_path do
        execute :docker, 'compose down'
      end
    end
  end

  desc 'Run Rails'
  task :run_rails do
    on roles(:app) do
      within current_path do
        execute :docker, 'compose exec store sh /app/docker-entrypoint.sh'
      end
    end
  end

  after :published, 'deploy:stop_old_container'
  after :published, 'deploy:start_docker_services'
  after :published, 'deploy:start_copy_env'
  after :published, 'deploy:run_db_migration'
  after :published, 'deploy:run_rails'
end
