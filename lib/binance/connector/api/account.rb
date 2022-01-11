# frozen_string_literal: true

module Binance
  module Connector
    module Api
      module Account
        def self.new_order_test(symbol, side, type, time_in_force, quantity, quote_quantity, price)
          params = {
            symbol: symbol,
            side: side,
            type: type,
            timeInForce: time_in_force,
            quantity: quantity,
            quoteOrderQty: quote_quantity,
            price: price
          }
          HttpClient.post(Api.url('/api/v3/order/test'), Api.options(params, :trade))
        end

        def self.new_order(symbol, side, type, time_in_force, quantity, quote_quantity, price)
          params = {
            symbol: symbol,
            side: side,
            type: type,
            timeInForce: time_in_force,
            quantity: quantity,
            quoteOrderQty: quote_quantity,
            price: price
          }
          HttpClient.post(Api.url('/api/v3/order'), Api.options(params, :trade))
        end

        def self.cancel_order(symbol, order_id)
          params = {
            symbol: symbol,
            orderId: order_id
          }
          HttpClient.delete(Api.url('/api/v3/order'), Api.options(params, :trade))
        end

        def self.cancel_open_orders(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.delete(Api.url('/api/v3/openOrders'), Api.options(params, :trade))
        end

        def self.get_order(symbol, order_id)
          params = {
            symbol: symbol,
            orderId: order_id
          }
          HttpClient.get(Api.url('/api/v3/order'), Api.options(params, :user_data))
        end

        def self.get_open_orders(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.get(Api.url('/api/v3/openOrders'), Api.options(params, :user_data))
        end

        def self.get_orders(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.get(Api.url('/api/v3/allOrders'), Api.options(params, :user_data))
        end

        def self.account
          params = {}
          HttpClient.get(Api.url('/api/v3/account'), Api.options(params, :user_data))
        end

        def self.my_trades(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.get(Api.url('/api/v3/myTrades'), Api.options(params, :user_data))
        end
      end
    end
  end
end
