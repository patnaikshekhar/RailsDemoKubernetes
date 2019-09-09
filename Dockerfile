# FROM ruby:2.6.3

# RUN gem install bundler:2.0.2
# RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
#     && apt install -y nodejs

# ENV RAILS_ENV production

# COPY . /app
# WORKDIR /app
# RUN bundle install --deployment --without development test

# ENTRYPOINT ./entrypoint.sh

FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /app
RUN gem install bundler:2.0.2

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --deployment --without development test

COPY . /app

ENV RAILS_ENV production

# Start the main process.
ENTRYPOINT ./entrypoint.sh