# Archangel

[![Travis CI](https://travis-ci.org/archangel/archangel.svg?branch=master)](https://travis-ci.org/archangel/archangel)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ecd913526457e79b49bd/test_coverage)](https://codeclimate.com/github/archangel/archangel/test_coverage)
[![Code Climate](https://codeclimate.com/github/archangel/archangel/badges/gpa.svg)](https://codeclimate.com/github/archangel/archangel)

![Archangel](archangel.png "Archangel")

**\*Archangel is currently under development. It is not ready for production use.\***

Archangel is a Rails CMS.

[Online documentation is available](http://www.rubydoc.info/github/archangel/archangel/master)

## Requirements

* Ruby 2.7.0 (See `.ruby-version`)
* Node 10.16.0 (See `.nvmrc`)
* Imagemagick

Additional requirements for `development` and `test` environment:

* Google Chrome
  * Install using [Homebrew Cask](https://github.com/Homebrew/homebrew-cask) with `brew cask install google-chrome`
* Chromedriver
  * Install using [Homebrew Cask](https://github.com/Homebrew/homebrew-cask) with `brew cask install chromedriver`

## Installation

Set up application

```
$ bin/setup
```

### Environment Variables

Environment variables are found in  `.env` file as needed

```
$ cp -i .env.sample .env
```

### Seed data

Add sample data to the database

```
$ bin/rails db:seed
```

## Updating

Run migrations

```
$ bin/rails db:migrate
```

Dependencies can be updated by running the manager

```
$ bundle install
$ yarn
```

## Running

### Puma

Run using the internal Rails server

```
$ bin/rails server
```

### Docker

```
$ docker-compose build
$ docker-compose run app rails db:setup
$ docker-compose run app rails db:create
$ docker-compose run app rails db:migrate
$ docker-compose up
```

Seed data

```
$ docker-compose run app rails db:seed
```

## Code Analysis

* [Travis CI](https://travis-ci.org/) is used for running tests.
* [Code Climate](https://codeclimate.com/) is used to analyze overall maintainability.

## Developers

General documentation for developers

* [Contributing Guide](https://github.com/archangel/archangel/blob/master/CONTRIBUTING.md)
* [Documentation for Archangel gem developers](https://github.com/archangel/archangel/blob/master/docs/Developers.md)
* [Documentation for extension developers](https://github.com/archangel/archangel/blob/master/docs/Extension/Developers.md)
* [Documentation for theme developers](https://github.com/archangel/archangel/blob/master/docs/Theme/Developers.md)
* [Documentation for releasing a gem version](https://github.com/archangel/archangel/blob/master/docs/Release.md) (maintainers only)

## Special Thanks

Archangel's logo was created by [Joshua Boyd](http://www.joshadamboyd.com/).

[@archangel-dlt](https://github.com/archangel-dlt/) originally had the "archangel" gem name and were kind enough to give it up

## Contributing

A [contributing guide](https://github.com/archangel/archangel/blob/master/CONTRIBUTING.md) is available.

1. Fork it ([https://github.com/archangel/archangel/fork](https://github.com/archangel/archangel/fork))
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
