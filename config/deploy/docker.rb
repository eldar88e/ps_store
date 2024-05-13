namespace :docker do
  desc 'Restart Docker Compose services'
  task :restart do
    on roles(:app) do
      execute "docker-compose down"
      execute "docker-compose up --build"
    end
  end
end

after 'deploy:published', 'docker:restart'