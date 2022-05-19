# frozen_string_literal: true

module Binance
  module Connector
    module Api
      def self.base_url
        ENV.fetch('BINANCE_BASE_URL')
      end

      def self.api_key
        ENV.fetch('BINANCE_API_KEY')
      end

      def self.secret_key
        ENV.fetch('BINANCE_SECRET_KEY')
      end

      def self.url(path)
        base_url + path
      end

      def self.options_unsigned(params)
        { query: params.compact }
      end

      def self.options_signed(params)
        { query: sign_params(params.compact), headers: { 'X-MBX-APIKEY': api_key } }
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
