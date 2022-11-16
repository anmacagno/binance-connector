# frozen_string_literal: true

module Binance
  module Connector
    module Contracts
      class TickerPriceContract < ApplicationContract
        schema do
          optional(:symbol).filled(:string, format?: SYMBOL_REGEXP)
          optional(:symbols).value(:array, min_size?: 1).each { str? & filled? & format?(SYMBOL_REGEXP) }

          after(:rule_applier) do |result|
            result.output[:symbols] = result.output[:symbols].to_s.delete(' ') if result.key?(:symbols)
          end
        end

        rule(:symbol, :symbols) do
          base.failure('must only contain one of: symbol, symbols') if key?(:symbol) && key?(:symbols)
        end
      end
    end
  end
end
