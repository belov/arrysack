# Arrysack

Arrysack is [Ransack](https://github.com/activerecord-hackery/ransack) for ruby array

Gem bring filter for array like query.

## Status

!!!! ALPHA, NOT FOR PRODUCTION !!!!

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add arrysack

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install arrysack

## Usage

Simple example:

```ruby
users = [{ first_name: 'Alex', birthdate: Date.new(2005,8,7) }, 
         { first_name: 'Nina', birthdate: Date.new(2000,8,7) }]
users.arrysack({ first_name_cont: 'A' }).result
#=> [{:first_name=>"Alex", :birthdate=>#<Date: 2005-08-07 ((2453590j,0s,0n),+0s,2299161j)>}]
users.arrysack({birthdate_gt: '2002-05-06'}).result
#=> [{:first_name=>"Alex", :birthdate=>#<Date: 2005-08-07 ((2453590j,0s,0n),+0s,2299161j)>}]
```

Example with schema:

```ruby
users = [{ first_name: 'Alex', birthdate: Date.new(2005,8,7) }, 
         { first_name: 'Nina', birthdate: Date.new(2000,8,7) }]
users.arrysack({ first_name_cont: 'A' }, { type: :object, properties: { first_name: { type: :string } } }).result
#=> [{:first_name=>"Alex", :birthdate=>#<Date: 2005-08-07 ((2453590j,0s,0n),+0s,2299161j)>}]
users.arrysack({birthdate_gt: '2002-05-06'}, { type: :object, properties: { first_name: { type: :string } } }).result
#=> [{:first_name=>"Alex", :birthdate=>#<Date: 2005-08-07 ((2453590j,0s,0n),+0s,2299161j)>}, {:first_name=>"Nina", :birthdate=>#<Date: 2000-08-07 ((2451764j,0s,0n),+0s,2299161j)>}]
```

Advanced example:

(not correct)
```ruby
users = [{ first_name: 'Alex', birthdate: Date.new(2005,8,7) }, 
         { first_name: 'Nina', birthdate: Date.new(2000,8,7) }]
users.arrysack({ first_name_cont: 'A' }).result
#=> [{:first_name=>"Alex", :birthdate=>#<Date: 2005-08-07 ((2453590j,0s,0n),+0s,2299161j)>}]
users.arrysack({birthdate_gt: '2002-05-06'}).result
#=> [{:first_name=>"Alex", :birthdate=>#<Date: 2005-08-07 ((2453590j,0s,0n),+0s,2299161j)>}]
```

## TODO

1. Tests for types, parsers, groups, query
2. Compare Advanced mode with Ransack and fix difference
3. Merge schemas
4. Schema extraction by many elements of list
5. I18n integration

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, 
which will create a git tag for the version, push git commits and the created tag, 
and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/belov/arrysack. 
This project is intended to be a safe, welcoming space for collaboration, 
and contributors are expected to adhere to the [code of conduct](https://github.com/belov/arrysack/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Arrysack project's codebases, issue trackers, 
chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/belov/arrysack/blob/master/CODE_OF_CONDUCT.md).
