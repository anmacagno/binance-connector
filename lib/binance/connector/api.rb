# frozen_string_literal: true

module Binance
  module Connector
    module Api
      BASE_URL = 'https://api.binance.com'

      def self.api_key
        ENV.fetch('BINANCE_API_KEY')
      end

      def self.secret_key
        ENV.fetch('BINANCE_SECRET_KEY')
      end

      def self.url(path)
        BASE_URL + path
      end

      def self.options(params, security_type = :none)
        params.compact!
        case security_type
        when :none
          { query: params }
        when :trade, :margin, :user_data
          { query: sign_params(params), headers: { 'X-MBX-APIKEY': api_key } }
        when :user_stream, :market_data
          { query: params, headers: { 'X-MBX-APIKEY': api_key } }
        end
      end

      def self.sign_params(params)
        signed_params = params.merge({ recvWindow: 5000, timestamp: timestamp })
        signature = OpenSSL::HMAC.hexdigest(
          OpenSSL::Digest.new('SHA256'), secret_key, URI.encode_www_form(signed_params)
        )
        signed_params.merge({ signature: signature })
      end

      def self.timestamp
        Time.now.utc.strftime('%s%3N')
      end
    end
  end
end
