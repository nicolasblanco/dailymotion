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

## Upload a video

First obtain an 'upload' URL :

    req = daily_api.get_object "file", "upload"
    url = req.body.upload_url

Then send a file to this URL, for example:

    req = daily_api.upload_file "video.m4v", url
    uploaded_file_url = req.body.url

Then post the video to Dailymotion :

    req = daily_api.post_video(uploaded_file_url)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
