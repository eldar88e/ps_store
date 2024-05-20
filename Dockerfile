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
RUN gem update --system 3.5.9
RUN gem install bundler -v $(tail -n 1 Gemfile.lock)
#RUN bundle config set path 'vendor/bundle'
#RUN bundle config set without 'development test'
bundle config set --local with 'production'
RUN bundle check || bundle install

COPY package.json yarn.lock /app/
RUN yarn install --check-files

COPY . /app/
# COPY ./../shared/config/master.key /app/config/master.key
# COPY ./../../shared/.env /app/.env

#ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]