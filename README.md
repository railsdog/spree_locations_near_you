# spree_locations_near_you
Spree extension to provide a list of retail locations near a users' provided postal code

# What this gem does

- Target Spree 2.4 in the first release
- Provide a means of geocoding any given ActiveRecord model based on address
- Supports a single geocoding provider
- Provides a facility for looking up a user-submitted location identifier (presumably a postal code) and returning a  ActiveRecord result set of locations sorted by ascending distance from the supplied starting point

## What this gem does not do

- Provide its own location / store AR model
- Support all versions of Spree
