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

        def self.exchange_info(args = {})
          result = Contracts::ExchangeInfoContract.validate!(args)
          HttpClient.get(Api.url('/api/v3/exchangeInfo'), Api.options_unsigned(result.to_h))
        end

        def self.klines(args = {})
          result = Contracts::KlinesContract.validate!(args)
          HttpClient.get(Api.url('/api/v3/klines'), Api.options_unsigned(result.to_h))
        end

        def self.avg_price(args = {})
          result = Contracts::AvgPriceContract.validate!(args)
          HttpClient.get(Api.url('/api/v3/avgPrice'), Api.options_unsigned(result.to_h))
        end

        def self.ticker_price(args = {})
          result = Contracts::TickerPriceContract.validate!(args)
          HttpClient.get(Api.url('/api/v3/ticker/price'), Api.options_unsigned(result.to_h))
        end
      end
    end
  end
end
