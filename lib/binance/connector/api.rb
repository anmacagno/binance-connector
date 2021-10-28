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
        case security_type
        when :none
          { query: params }
        when :trade, :margin, :user_data
          { query: params.merge(signature: sign_params(params)), headers: { 'X-MBX-APIKEY': api_key } }
        when :user_stream, :market_data
          { query: params, headers: { 'X-MBX-APIKEY': api_key } }
        end
      end

      def self.sign_params(params)
        data = params.map { |key, value| "#{key}=#{value}" }.join('&')
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('SHA256'), secret_key, data)
      end

      def self.timestamp
        Time.now.utc.strftime('%s%3N')
      end
    end
  end
end
