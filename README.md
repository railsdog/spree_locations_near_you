SpreeLocationsNearYou
=====================

[![Circle CI](https://circleci.com/gh/railsdog/spree_locations_near_you.svg?style=svg)](https://circleci.com/gh/railsdog/spree_locations_near_you) [![Code Climate](https://codeclimate.com/github/railsdog/spree_locations_near_you/badges/gpa.svg)](https://codeclimate.com/github/railsdog/spree_locations_near_you)

# spree_locations_near_you
Spree extension to provide a list of retail locations near a users' provided postal code

# What this gem does

- Target Spree 2.4 in the first release
- Provide a means of geocoding any given ActiveRecord model based on address
- Supports a single geocoding provider
- Provides a facility for looking up a user-submitted location identifier (presumably a postal code) and returning a  ActiveRecord result set of locations sorted by ascending distance from the supplied starting point
- Delegates to the `alexreisner/geocoder` where possible to simplify `(lat,lng)` lookups
- Targets PostgreSQL exclusively using the `earthdistance` addon.
  - May support MySQL via its [spatial extensions](http://dev.mysql.com/doc/refman/5.0/en/spatial-extensions.html) in a future release
- Provides a vendored copy of the [jQuery Store Locator Plugin](https://github.com/bjorn2404/jQuery-Store-Locator-Plugin) for optional frontend mapping needs
- Uses the `acts_as_list` gem's DSL as a guideline for inclusion with a Spree model specified by the gem user

## What this gem does not do

- Provide its own location / store AR model
- Support all versions of Spree

Installation
------------

Add spree_locations_near_you to your Gemfile:

```ruby
gem 'spree_locations_near_you'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_locations_near_you:install
```

Testing
-------

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_locations_near_you/factories'
```

Copyright (c) 2015 [name of extension creator], released under the New BSD License
=======
>>>>>>> 52a513fa8d985d1757a1f1f982efafc09c83e49b
