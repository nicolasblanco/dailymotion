module Dailymotion
  class API
    API_BASE_URL = 'https://api.dailymotion.com'
    attr_accessor :options
    attr_reader :faraday, :faraday_post

    def initialize(opts = {})
      @options = opts

      set_faradays
    end

    def set_faradays
      @faraday = Faraday.new(:url => API_BASE_URL) do |builder|
        builder.use Dailymotion::FaradayMiddleware::OAuth2, @options[:token]
        builder.use Faraday::Response::Logger
        builder.adapter Faraday.default_adapter

        builder.use ::FaradayMiddleware::Mashify
        builder.use ::FaradayMiddleware::ParseJson
      end

      @faraday_post = Faraday.new do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded

        builder.adapter Faraday.default_adapter

        builder.use ::FaradayMiddleware::Mashify
        builder.use ::FaradayMiddleware::ParseJson
      end
    end

    def get_object(object, id, params = {})
      @faraday.get do |req|
        req.url "/#{object}/#{id}"
        req.params = params
      end
    end

    def get_connection(object, id, connection, params = {})
      @faraday.get do |req|
        req.url "/#{object}/#{id}/#{connection}"
        req.params = params
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
      payload = { :file => Faraday::UploadIO.new(filepath, "application/octet-stream") }

      @faraday_post.post url, payload
    end

    def refresh_token!
      raise StandardError, "client_id, client_secret and refresh_token in options hash are mandatory" unless options[:client_id] && options[:client_secret] && options[:refresh_token]

      refresh_request = @faraday_post.post "#{API_BASE_URL}/oauth/token", { :grant_type => "refresh_token", :client_id => @options[:client_id], :client_secret => @options[:client_secret], :refresh_token => @options[:refresh_token] }
      @options[:token] = refresh_request.body.access_token

      set_faradays
    end
  end
end
