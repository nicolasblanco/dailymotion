module Dailymotion
  class API
    attr_accessor :token, :faraday

    def initialize(token)
      @token = token
      @faraday = Faraday.new(:url => 'https://api.dailymotion.com') do |builder|
        builder.use Dailymotion::FaradayMiddleware::OAuth2, @token
        builder.use Faraday::Response::Logger     # log the request to STDOUT
        builder.adapter Faraday.default_adapter     # make http requests with Net::HTTP

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
  end
end
