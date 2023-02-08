# frozen_string_literal: true

module Binance
  module Connector
    module Contracts
      class GetOpenOrdersContract < ApplicationContract
        schema do
          optional(:symbol).filled(:string, format?: SYMBOL_REGEXP)
        end
      end
    end
  end
end
