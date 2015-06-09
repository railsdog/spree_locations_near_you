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
