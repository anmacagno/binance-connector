# frozen_string_literal: true

module Binance
  module Connector
    module Contracts
      class KlinesContract < ApplicationContract
        schema do
          required(:symbol).filled(:string, format?: SYMBOL_REGEXP)
          required(:interval).filled(:string, included_in?: KLINE_INTERVALS)
          optional(:startTime).value(:time)
          optional(:endTime).value(:time)
          optional(:limit).value(:integer, gteq?: 1, lteq?: 1000)

          after(:rule_applier) do |result|
            result.output[:startTime] = result.output[:startTime].strftime('%s%3N') if result.key?(:startTime)
            result.output[:endTime] = result.output[:endTime].strftime('%s%3N') if result.key?(:endTime)
          end
        end
      end
    end
  end
end
