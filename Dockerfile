FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    node.js \
    yarn \
	vim \
    imagemagick
ENV LANG C.UTF-8
WORKDIR /favrip
COPY Gemfile Gemfile.lock /favrip/
RUN bundle install
