FROM ruby:3.2.2-buster

WORKDIR /application
COPY Gemfile /application/Gemfile
COPY Gemfile.lock /application/Gemfile.lock
RUN bundle install

COPY . /application