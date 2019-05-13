# ProveKeybase
[![Travis CI](https://travis-ci.org/keybase/prove_keybase.svg?branch=master)](https://travis-ci.org/keybase/prove_keybase)

This is a drop-in implementation of Keybase's open proof protocol for Ruby on Rails. Here is a generic [implementation guide](https://keybase.io/docs/proof_integration_guide) and [announcement](https://keybase.io/blog/keybase-proofs-for-mastodon-and-everyone) for the protocol.

## Installation

This documentation assumes that `User` is the model and table off of which `keybase_proofs` will hang. If this is not the case for your app, just replace accordingly.

1. Add the gem and `bundle install`
```ruby
gem 'prove_keybase'
```
2. Run the generator to create the migration for a new table and an initializer file.
```bash
bundle exec rails generate prove_keybase install
```
3. Edit those two files for your site details. The comments in those files will guide you through it.
4. Add `is_keybase_provable` to your User model like this:
```ruby
class User < ApplicationRecord
  is_keybase_provable
end
```
5. Add the engine to your routes file like this:
```ruby
mount ProveKeybase::Engine => "/prove_keybase"
```
6. Override some of the behavior to customize. This step is not optional. See below.
7. Validate your hosted config against Keybase to see if everything is pulling through correctly:
```bash
curl https://keybase.io/_/api/1.0/validate_proof_config.json\?config_url\=https://#{YOUR-SITE.COM}/prove_keybase/config.json
> {"status":{"code":0,"name":"OK"}}
```
8. Add keybase proofs to your users' profiles. [Here](spec/dummy/app/views/users/show.html.erb) is an ugly example of this in the dummy app. You can also check out how this looks on other sites that have implemented the protocol.
9. Send a keybase chat message to `@xgess` or `@mlsteele` to validate and flip on the integration from the Keybase side. If you message before this point, one of them can also help you test the whole thing end-to-end.

## Overrides

### Definitely do this
First and foremost, the view template to create a new proof is ugly as sin. This is intentional. Please make it look and feel like it's part of your site, which it is. For an example of how to do this, [here](app/views/prove_keybase/proofs/new.html.erb) is the view you need to override, and [here](spec/dummy/app/views/prove_keybase/proofs/new.html.erb) it is being overridden in the dummy app. The generator should have put a file in the right place.

### Consider doing this
A lot of the controller behavior, especially around handling authentication, is constructed in this gem with subclassing / method-overriding in mind and some assumptions about, for example, identifying the logged-in user. Take a look at the [KeybaseBaseController](app/controllers/prove_keybase/keybase_base_controller.rb). All of these methods _can_ (and some _should_) be overridden. The generator should have put a file in the right place with some notes to get you started. The dummy app has an [example](spec/dummy/app/controllers/keybase_base_controller.rb).

## Keeping data up-to-date
It's always possible for a user to revoke their proof in Keybase. To ensure that your site is not linking to a broken proof, we have a couple of suggestions. The behavior that checks Keybase for a proof and updates your `keybase_proofs` table is accessible through an async job called `UpdateFromKeybaseJob`. Keybase would prefer if you did not call this every time every user sees another user's proofs. A nice compromise is to fire this off whenever a user looks at their own proofs. We do this in the dummy app [here](spec/dummy/app/controllers/users_controller.rb).

There is also a rake task in the gem that explains how you might consider updating all of the proofs at the same time.
```
bundle exec rake prove_keybase:update_proofs
```

## Contributing

Normal stuff. Run the tests:
```bash
bundle exec rake
```
And if you have access to a locally running set of Keybase servers, I recommend setting up a proxy for the dummy app e.g. `ngrok http 3001` and running it like this
```
PORT=3001 KEYBASE_BASE_URL=http://localhost:3000 KEYBASE_MY_DOMAIN=8f9e4887.ngrok.io be rails s
```

## License
The gem is available as open source under the terms of this [license](./LICENSE).

