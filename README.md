# Spaziergang Creator [![Build Status](https://travis-ci.org/Datenschule/spaziergang-creator.svg?branch=master)](https://travis-ci.org/Datenschule/spaziergang-creator) [![Coverage Status](https://coveralls.io/repos/github/Datenschule/spaziergang-creator/badge.svg)](https://coveralls.io/github/Datenschule/spaziergang-creator)

## What is this?

Spaziergang Creator a web-based tool to create your own [Datenspaziergang](https://github.com/Datenschule/datenspaziergang-app).

It also serves as an API server for the mentioned frontend app.

## Local setup

> Ruby 2.5.1
> A recent version of node

Clone the repo and run `$ bundle` (install bundler via `gem install bundler` if you haven't yet).

Copy and adjust the database config `$ cp config/database.yml.example config/database.yml`.

Setup database and run migrations `$ rails db:create db:migrate`.

Install JavaScript dependencies via npm/yarn `$ npm install` `$ yarn install`.

Start the dev server `$ rails s`.

## Tests

Run tests locally via `$ rspec`.

## Deployment

TBW

## API docs

There are two API endpoints, `/api/v1/walks` and `/api/v1/walks/:id` serving a list of public walks and details of one walk respectively.

The payloads are designed to match [the original payload of the prototype](https://github.com/Datenschule/datenspaziergang-app/wiki).
