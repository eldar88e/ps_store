FROM ruby:3.2.2-alpine AS ps

ENV TZ="Europe/Moscow"
RUN apk --update add \
    build-base \
    postgresql-dev \
    postgresql-client \
    tzdata \
    yarn \
    git \
    && rm -rf /var/cache/apk/*

ENV RAILS_ENV="development"

WORKDIR /app

COPY Gemfile /app/
#
#RUN gem update --system 3.5.3
#
#RUN gem install bundler -v $(tail -n 1 Gemfile.lock)
#RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install --path vendor/bundle

COPY package.json yarn.lock /app/
RUN yarn install --check-files

COPY ./ /app/

CMD /bin/ash
#CMD ./bin/dev
