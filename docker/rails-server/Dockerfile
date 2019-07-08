FROM ruby:2.5-alpine

RUN apk update && apk add build-base nodejs postgresql-dev postgresql imagemagick bash

RUN mkdir /app
WORKDIR /app

COPY . .

RUN bundle install

CMD "bundle exec rails s -b 0.0.0.0"
