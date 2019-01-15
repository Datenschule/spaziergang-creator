FROM ruby:2.6-slim-stretch

RUN apt-get update \
    && apt-get install -qq -y build-essential libpq-dev curl wget gnupg2 vim \
    --fix-missing --no-install-recommends \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -qq -y nodejs yarn \
    && apt-get clean \
    && rm -f /var/lib/apt/lists/*_* \
    && mkdir -p /app

WORKDIR /app

COPY Gemfile Gemfile.lock ./
COPY config/database.yml.example ./config/database.yml

RUN bundle install \
    && yarn install \
    && bundle exec rails assets:precompile

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["puma", "-C", "config/puma.rb"]
