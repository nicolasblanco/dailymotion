module Dailymotion
  module FaradayMiddleware
    class OAuth2 < Faraday::Middleware
      def call(env)
        env[:request_headers]['Authorization'] = "OAuth #{@access_token}"

        @app.call(env)
      end

      def initialize(app, access_token)
        @app, @access_token = app, access_token
      end
    end
  end
end
