[![Build Status](https://travis-ci.org/bartlomiejh/easy_post.svg)](https://travis-ci.org/bartlomiejh/easy_post)
[![Coverage Status](https://coveralls.io/repos/bartlomiejh/easy_post/badge.svg?branch=master&service=github)](https://coveralls.io/github/bartlomiejh/easy_post?branch=master)
[![Dependency Status](https://gemnasium.com/bartlomiejh/easy_post.svg)](https://gemnasium.com/bartlomiejh/easy_post)

# EasyPost

Ruby wrapper for easyPack parcel lockers API (https://api-pl.easypack24.net/v4/machines?type=0).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_post'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_post

## Usage

To get list of all parcel lockers run:
```ruby
    EasyPost::ParcelLocker.all
```

To get parcel locker by its id run:
```ruby
    EasyPost::ParcelLocker.find('id')
```

To render select list with all parcel lockers use helper:
```ruby
    <%= select_parcel_locker :select_id %>
```
Helper described above is facade over select_tag so you can also pass all html options that select tag can take :
```ruby
    <%= select_parcel_locker :select_id, {class: 'my-class', style: 'color: red;'} %>
```
Additionally you can pass type value of parcel lockers that you want to render:
```ruby
    <%= select_parcel_locker :select_id, {class: 'my-class', style: 'color: red;'}, type_value %>
```

All API requests are cached via ActiveSupport::Cache::FileStore under `File.join(ENV['TMPDIR'] || '/tmp', 'cache')` for 1 hour.

To change api endpoint or caching parameters initialize EasyPost with new values during startup:
```ruby
    EasyPost.configure do |config|
      config.api_endpoint = 'https://my.api.endpoint'
      config.cache_dir = 'my/cache/dir'
      config.cache_expires_s = 30 #expires in 30s
    end
```

## Documentation

For now the only place for documentation is project spec directory

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bartlomiejh/easy_post.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

