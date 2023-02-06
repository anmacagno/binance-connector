# frozen_string_literal: true

module Binance
  module Connector
    class Api
      module Market
        def ping
          HttpClient.get(url('/api/v3/ping'))
        end

        def time
          HttpClient.get(url('/api/v3/time'))
        end

        def exchange_info(args = {})
          result = Contracts::ExchangeInfoContract.validate!(args)
          HttpClient.get(url('/api/v3/exchangeInfo'), options_unsigned(result.to_h))
        end

        def klines(args = {})
          result = Contracts::KlinesContract.validate!(args)
          HttpClient.get(url('/api/v3/klines'), options_unsigned(result.to_h))
        end

        def avg_price(args = {})
          result = Contracts::AvgPriceContract.validate!(args)
          HttpClient.get(url('/api/v3/avgPrice'), options_unsigned(result.to_h))
        end

        def ticker_price(args = {})
          result = Contracts::TickerPriceContract.validate!(args)
          HttpClient.get(url('/api/v3/ticker/price'), options_unsigned(result.to_h))
        end
      end
    end
  end
end
