FROM ruby:latest

# throw errors if Gemfile has been modified
RUN bundle config --global frozen 1

WORKDIR /usr/src/app/

COPY Gemfile Gemfile.lock ./
RUN bundle install

ADD . /usr/src/app/

EXPOSE 4000

CMD ["ruby", "/usr/src/app/helloworld.rb"]
