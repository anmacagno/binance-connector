# frozen_string_literal: true

module Binance
  module Connector
    module Api
      module Market
        def self.ping
          HttpClient.get(Api.url('/api/v3/ping'))
        end

        def self.time
          HttpClient.get(Api.url('/api/v3/time'))
        end

        def self.exchange_info(symbols)
          params = {
            symbols: symbols.to_s.gsub(' ', '')
          }
          HttpClient.get(Api.url('/api/v3/exchangeInfo'), Api.options_unsigned(params))
        end

        def self.klines(symbol, interval, start_time, end_time, limit)
          params = {
            symbol: symbol,
            interval: interval,
            startTime: start_time,
            endTime: end_time,
            limit: limit
          }
          HttpClient.get(Api.url('/api/v3/klines'), Api.options_unsigned(params))
        end

        def self.avg_price(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.get(Api.url('/api/v3/avgPrice'), Api.options_unsigned(params))
        end

        def self.ticker_price(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.get(Api.url('/api/v3/ticker/price'), Api.options_unsigned(params))
        end
      end
    end
  end
end
