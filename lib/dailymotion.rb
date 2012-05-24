require "faraday"
require "faraday_middleware"
require "dailymotion/version"
require "dailymotion/faraday/oauth2_middleware"

module Dailymotion
  class API
    attr_accessor :token, :faraday

    def initialize(token)
      @token = token
      @faraday = Faraday.new(:url => 'https://api.dailymotion.com') do |builder|
        builder.use Faraday::Request::UrlEncoded  # convert request params as "www-form-urlencoded"
        builder.use Faraday::Request::DailymotionOAuth2, @token
        builder.use Faraday::Response::Logger     # log the request to STDOUT
        builder.adapter Faraday.default_adapter     # make http requests with Net::HTTP

        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson
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
  end
end
