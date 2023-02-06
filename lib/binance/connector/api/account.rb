# frozen_string_literal: true

module Binance
  module Connector
    class Api
      module Account
        def new_order_test(symbol, side, type, time_in_force, quantity, quote_quantity, price)
          params = {
            symbol: symbol,
            side: side,
            type: type,
            timeInForce: time_in_force,
            quantity: quantity,
            quoteOrderQty: quote_quantity,
            price: price
          }
          HttpClient.post(url('/api/v3/order/test'), options_signed(params))
        end

        def new_order(symbol, side, type, time_in_force, quantity, quote_quantity, price)
          params = {
            symbol: symbol,
            side: side,
            type: type,
            timeInForce: time_in_force,
            quantity: quantity,
            quoteOrderQty: quote_quantity,
            price: price
          }
          HttpClient.post(url('/api/v3/order'), options_signed(params))
        end

        def cancel_order(symbol, order_id)
          params = {
            symbol: symbol,
            orderId: order_id
          }
          HttpClient.delete(url('/api/v3/order'), options_signed(params))
        end

        def cancel_open_orders(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.delete(url('/api/v3/openOrders'), options_signed(params))
        end

        def get_order(symbol, order_id)
          params = {
            symbol: symbol,
            orderId: order_id
          }
          HttpClient.get(url('/api/v3/order'), options_signed(params))
        end

        def get_open_orders(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.get(url('/api/v3/openOrders'), options_signed(params))
        end

        def get_orders(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.get(url('/api/v3/allOrders'), options_signed(params))
        end

        def account
          params = {}
          HttpClient.get(url('/api/v3/account'), options_signed(params))
        end

        def my_trades(symbol, order_id)
          params = {
            symbol: symbol,
            orderId: order_id
          }
          HttpClient.get(url('/api/v3/myTrades'), options_signed(params))
        end
      end
    end
  end
end
