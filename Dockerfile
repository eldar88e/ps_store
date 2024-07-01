FROM ruby:3.2.2-alpine AS web

RUN apk --update add --no-cache \
    build-base \
    postgresql-dev \
    postgresql-client \
    tzdata \
    yarn \
    git \
    glib \
    libc6-compat \
    && rm -rf /var/cache/apk/*

WORKDIR /app

COPY Gemfile* ./
RUN gem update --system 3.5.14
RUN gem install bundler -v $(tail -n 1 Gemfile.lock)
RUN bundle config set without 'development test'
RUN bundle check || bundle install

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY . ./

# ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]