# frozen_string_literal: true

require_relative 'api/account'
require_relative 'api/market'
require_relative 'api/wallet'

module Binance
  module Connector
    class Api
      include Binance::Connector::Api::Account
      include Binance::Connector::Api::Market
      include Binance::Connector::Api::Wallet

      BASE_URL = 'https://api.binance.com'

      attr_reader :api_key, :secret_key, :base_url

      def initialize(api_key: '', secret_key: '', base_url: BASE_URL)
        @api_key = api_key
        @secret_key = secret_key
        @base_url = base_url
      end

      def url(path)
        base_url + path
      end

      def options_unsigned(params)
        { query: params.compact }
      end

      def options_signed(params)
        {
          query: sign_params(params.compact),
          headers: { 'X-MBX-APIKEY': api_key }
        }
      end

      private

      def sign_params(params)
        signed_params = params.merge({ recvWindow: 5000, timestamp: Time.now.utc.strftime('%s%3N') })
        signature = hmac_sign(URI.encode_www_form(signed_params))
        signed_params.merge({ signature: signature })
      end

      def hmac_sign(data)
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('SHA256'), secret_key, data)
      end
    end
  end
end
