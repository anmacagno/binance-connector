# frozen_string_literal: true

module Binance
  module Connector
    module Contracts
      class CancelOrderContract < ApplicationContract
        schema do
          required(:symbol).filled(:string, format?: SYMBOL_REGEXP)
          required(:orderId).value(:integer)
        end
      end
    end
  end
end
