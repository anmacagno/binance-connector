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

        def cancel_order(args = {})
          result = Contracts::CancelOrderContract.validate!(args)
          HttpClient.delete(url('/api/v3/order'), options_signed(result.to_h))
        end

        def cancel_open_orders(symbol)
          params = {
            symbol: symbol
          }
          HttpClient.delete(url('/api/v3/openOrders'), options_signed(params))
        end

        def get_order(args = {})
          result = Contracts::GetOrderContract.validate!(args)
          HttpClient.get(url('/api/v3/order'), options_signed(result.to_h))
        end

        def get_open_orders(args = {})
          result = Contracts::GetOpenOrdersContract.validate!(args)
          HttpClient.get(url('/api/v3/openOrders'), options_signed(result.to_h))
        end

        def get_orders(args = {})
          result = Contracts::GetOrdersContract.validate!(args)
          HttpClient.get(url('/api/v3/allOrders'), options_signed(result.to_h))
        end

        def account
          HttpClient.get(url('/api/v3/account'), options_signed)
        end

        def my_trades(args = {})
          result = Contracts::MyTradesContract.validate!(args)
          HttpClient.get(url('/api/v3/myTrades'), options_signed(result.to_h))
        end
      end
    end
  end
end
