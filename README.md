# Dailymotion

Ruby bindings for the [Dailymotion Graph API](http://www.dailymotion.com/doc/api/graph-api.html).

To authenticate your users with Dailymotion, I suggest you to use my [Omniauth Dailymotion Strategy](https://github.com/slainer68/omniauth-dailymotion).

## Installation

Add this line to your application's Gemfile:

    gem 'dailymotion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dailymotion

## Usage

Get the list of the authenticated user videos:

    daily_api = Dailymotion::API.new("API_TOKEN")
    resp = daily_api.get_connections("user", "me", "videos")

    resp.body

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
