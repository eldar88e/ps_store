FROM ruby:3.2.2-alpine AS web

RUN apk --update add \
    build-base \
    postgresql-dev \
    postgresql-client \
    tzdata \
    yarn \
    git \
    && rm -rf /var/cache/apk/*

WORKDIR /app

COPY Gemfile* /app/
RUN gem update --system 3.5.3
RUN gem install bundler -v $(tail -n 1 Gemfile.lock)
RUN bundle check || bundle install --path vendor/bundle --without development test

COPY package.json yarn.lock /app/
RUN yarn install --check-files

ENTRYPOINT './docker-entrypoint.sh'
