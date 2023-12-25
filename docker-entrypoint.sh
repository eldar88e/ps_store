#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

RAILS_ENV=production bundle exec ./bin/rails assets:precompile
./bin/dev
