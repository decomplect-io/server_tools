# Server Tools

A bunch of tools to provision (via Chef) and deploy packages to servers.

Available commands:

- `bootstrap`: Installs Chef on the provided host
- `provision`: Runs chef with the provided list of roles/recipes
- `install-deb-package`: Installs a local Debian package on the remote host (optionally purges the older version)

All command line flags can be seen by running `server_tools help`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'server_tools'
```

Or install directly via:
```ruby
gem install server_tools
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`. To release a new version, update the version number in `version.rb`, and then run `bin/rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/decomplect-io/server_tools.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
