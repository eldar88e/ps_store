server 'server.open-ps.ru',
       user: 'deploy',
       roles: %w{ app db web }

set :application, 'ps_store_staging'
set :deploy_to, "/home/deploy/#{fetch :application}"
