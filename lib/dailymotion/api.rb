module Dailymotion
  class API
    attr_accessor :token, :faraday

    def initialize(token)
      @token = token
      @faraday = Faraday.new(:url => 'https://api.dailymotion.com') do |builder|
        builder.use Dailymotion::FaradayMiddleware::OAuth2, @token
        builder.use Faraday::Response::Logger
        builder.adapter Faraday.default_adapter

        builder.use ::FaradayMiddleware::Mashify
        builder.use ::FaradayMiddleware::ParseJson
      end
    end

    def get_object(object, id)
      @faraday.get do |req|
        req.url "/#{object}/#{id}"
      end
    end

    def get_connection(object, id, connection)
      @faraday.get do |req|
        req.url "/#{object}/#{id}/#{connection}"
      end
    end
    alias_method :get_connections, :get_connection

    def post_object(object, id, params = {})
      @faraday.post do |req|
        req.url "/#{object}/#{id}"
        req.params = params
      end
    end

    def post_video(url)
      post_object("me", "videos", :url => url)
    end

    def upload_file(filepath, url)
      faraday = Faraday.new do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded

        builder.adapter Faraday.default_adapter

        builder.use ::FaradayMiddleware::Mashify
        builder.use ::FaradayMiddleware::ParseJson
      end

      payload = { :file => Faraday::UploadIO.new(filepath, "application/octet-stream") }

      faraday.post url, payload
    end
  end
end
