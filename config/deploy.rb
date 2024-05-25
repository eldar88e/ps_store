# config valid for current version and patch releases of Capistrano
lock "~> 3.18.1"

set :application, 'ps_store'
set :repo_url, 'git@github.com:eldar88e/ps_store.git'

# Default branch is :master
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp # 'main'

set :deploy_to, "/home/deploy/#{fetch :application}"
set :test_path, "#{fetch(:deploy_to)}/releases/test_#{Time.now.to_i}"
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
  current_path = "#{fetch(:deploy_to)}/current"

  desc 'Copy .env to Docker container'
  task :copy_env do
    on roles(:app) do
      within "#{fetch(:deploy_to)}" do
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

  desc 'Run DB prepare'
  task :run_db_prepare do
    on roles(:app) do
      within current_path do
        #execute :docker, 'compose exec store bundle install'
        execute :docker, 'compose exec store rails db:prepare'
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
        execute :docker, 'compose exec store /app/docker-entrypoint.sh'
      end
    end
  end

  ####### Test ########
  desc 'Deploy and run tests without switching to current'
  task :test do
    on roles(:app) do
      execute :mkdir, '-p', "#{fetch(:test_path)}"

      within "#{fetch(:test_path)}" do
        execute :git, "clone -b #{fetch(:branch)} #{fetch(:repo_url)} ."
        invoke 'deploy:updated'
        invoke 'deploy:start_docker_test_services'
        invoke 'deploy:copy_env_test'
        invoke 'deploy:run_test'
        invoke 'deploy:down_docker_compose_test'
      end

      within "#{fetch(:deploy_to)}" do
        invoke 'deploy:cleanup_test_releases'
        execute :echo, '🟢 Successfully tested!'
      end
    end
  end

  desc 'Stop and remove docker-test'
  task :stop_rm_docker_test do
    on roles(:app) do
      within "#{fetch(:deploy_to)}" do
        execute :docker, 'stop store-test && docker rm store-test'
        execute :docker, 'stop pg-store-test && docker rm pg-store-test'
      end
    end
  end

  desc 'Down docker-compose-test'
  task :down_docker_compose_test do
    on roles(:app) do
      within "#{fetch(:test_path)}" do
        execute :docker, 'compose -f docker-compose-test.yml down'
      end
    end
  end

  desc 'Start docker-compose-test services'
  task :start_docker_test_services do
    on roles(:app) do
      within "#{fetch(:test_path)}" do
        execute :docker, 'compose -f docker-compose-test.yml up --build -d'
      end
    end
  end

  desc 'Copy .env to Docker-test container'
  task :copy_env_test do
    on roles(:app) do
      within "#{fetch(:deploy_to)}" do
        execute "docker", "cp", "./.env", "store-test:/app"
      end
    end
  end

  desc 'Run Tests'
  task :run_test do
    on roles(:app) do
      within "#{fetch(:test_path)}" do
        execute :docker, 'compose exec store-test /app/docker-entrypoint-test.sh'
      end
    end
  end

  desc 'Remove all test releases'
  task :cleanup_test_releases do
    on roles(:app) do
      within "#{fetch(:deploy_to)}/releases" do
        execute :rm, '-rf', 'test_*'
      end
    end
  end
  ######### Test end #######

  after :published, 'deploy:stop_old_container'
  after :published, 'deploy:start_docker_services'
  after :published, 'deploy:copy_env'
  after :published, 'deploy:run_db_prepare'
  after :published, 'deploy:run_rails'
end
