#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails assets:precompile
bundle exec rails db:setup
bundle exec rspec
bundle exec cucumber
