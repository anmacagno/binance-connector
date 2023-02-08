# frozen_string_literal: true

module Binance
  module Connector
    module Contracts
      class MyTradesContract < ApplicationContract
        schema do
          required(:symbol).filled(:string, format?: SYMBOL_REGEXP)
          optional(:orderId).value(:integer)
        end
      end
    end
  end
end
