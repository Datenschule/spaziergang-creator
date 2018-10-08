# Spaziergang Creator [![Build Status](https://travis-ci.org/Datenschule/spaziergang-creator.svg?branch=master)](https://travis-ci.org/Datenschule/spaziergang-creator) [![Coverage Status](https://coveralls.io/repos/github/Datenschule/spaziergang-creator/badge.svg)](https://coveralls.io/github/Datenschule/spaziergang-creator)

## What is this?

Spaziergang Creator a web-based tool to create your own [Datenspaziergang](https://github.com/Datenschule/datenspaziergang-app).

It also serves as an API server for the mentioned frontend app.

## Development setup

> Ruby 2.5.1
> A recent version of node

Clone the repo and run `$ bundle` (install bundler via `gem install bundler` if you haven't yet).

Copy and adjust the database config `$ cp config/database.yml.example config/database.yml`.

Setup database and run migrations `$ rails db:create db:migrate`.

Install JavaScript dependencies via npm/yarn `$ npm install` or `$ yarn install`.

Start the dev server `$ rails s`.

## Tests

Run tests locally via `$ rspec`.

## Deployment/ Production

I use docker/ docker-compose to build and serve the production app.

The `docker-compose.yml` defines three services in a network:

- postgres, called `db`
- the Spaziergang Creator app, called `web`
- nginx to serve and cache static assets, called `nginx`

**Please adjust the variables in the docker-compose.yml before deployment!**

Give the database a proper name, user and password (db and web have to match) and change the `secret_key_base` in the web service. Adjust the port in nginx to whatever port you want to expose.

After that you can `$ docker-compose build` to build the images and `$ docker-compose up -d` to start the whole thing.

When you set this up for the **first time** don't forget run the database migrations with `$ docker exec spaziergang-creator_web_1 rails db:migrate`. Pid instead of container name also works.

Yay!


## API docs

There are two API endpoints, `/api/v1/walks` and `/api/v1/walks/:id` serving a list of public walks and details of one walk respectively.

The payloads are designed to match [the original payload of the prototype](https://github.com/Datenschule/datenspaziergang-app/wiki).
