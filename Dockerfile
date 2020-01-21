FROM ruby:2.5.0

RUN apt-get update -qq && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash && apt-get install nodejs -yq

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

RUN rake db:drop && rake db:create && rake db:migrate && rake db:seed

CMD ["rails", "server", "-p", "4000", "-b", "0.0.0.0"]
