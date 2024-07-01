server 'server.open-ps.ru',
       user: 'deploy',
       roles: %w{ app db web }

set :application, 'ps_store'
set :deploy_to, "/home/deploy/#{fetch :application}"
set :current_path, "#{fetch(:deploy_to)}/current"

namespace :deploy do
  desc 'Start docker-compose services'
  task :start_docker_services do
    on roles(:app) do
      within "#{fetch(:current_path)}" do
        execute :docker, 'compose up --build -d'
      end
    end
  end

  desc 'Stop old container and rails app'
  task :stop_old_container do
    on roles(:app) do
      within "#{fetch(:current_path)}" do
        execute :docker, 'compose down'
      end
    end
  end

  desc 'Remove gems volume'
  task :del_gem_vol do
    on roles(:app) do
      within "#{fetch(:current_path)}" do
        execute :docker, 'volume rm current_gems_store'
      end
    end
  end

  desc 'Copy .env to Docker container'
  task :copy_env do
    on roles(:app) do
      within "#{fetch(:deploy_to)}" do
        execute "docker", "cp", "./.env", "store:/app"
      end
    end
  end

  desc 'Run DB prepare'
  task :run_db_prepare do
    on roles(:app) do
      within "#{fetch(:current_path)}" do
        #execute :docker, 'compose exec store bundle install'
        execute :docker, 'compose exec store rails db:prepare'
      end
    end
  end

  desc 'Run Rails'
  task :run_rails do
    on roles(:app) do
      within "#{fetch(:current_path)}" do
        execute :docker, 'compose exec store /app/docker-entrypoint.sh'
      end
    end
  end
end
