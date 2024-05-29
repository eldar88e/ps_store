server 'server.open-ps.ru',
       user: 'deploy',
       roles: %w{ app db web }

set :application, 'ps_store_staging'

namespace :deploy do
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