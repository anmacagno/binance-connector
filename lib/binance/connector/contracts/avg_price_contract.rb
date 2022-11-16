# frozen_string_literal: true

module Binance
  module Connector
    module Contracts
      class AvgPriceContract < ApplicationContract
        schema do
          required(:symbol).filled(:string, format?: SYMBOL_REGEXP)
        end
      end
    end
  end
end
