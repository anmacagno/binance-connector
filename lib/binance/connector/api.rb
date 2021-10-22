# frozen_string_literal: true

module Binance
  module Connector
    module Api
      BASE_URL = 'https://api.binance.com'

      def self.url(path)
        BASE_URL + path
      end

      def self.ping
        HttpClient.get(url('/api/v3/ping'))
      end

      def self.time
        HttpClient.get(url('/api/v3/time'))
      end

      def self.exchange_info(symbols)
        options = { query: { symbols: symbols.to_s.gsub(' ', '') } }
        HttpClient.get(url('/api/v3/exchangeInfo'), options)
      end

      def self.avg_price(symbol)
        options = { query: { symbol: symbol } }
        HttpClient.get(url('/api/v3/avgPrice'), options)
      end
    end
  end
end
