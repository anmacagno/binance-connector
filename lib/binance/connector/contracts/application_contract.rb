# frozen_string_literal: true

module Binance
  module Connector
    module Contracts
      require 'dry-validation'

      class ApplicationContract < Dry::Validation::Contract
        SYMBOL_REGEXP = /^[A-Z0-9\-_.]{1,20}$/
        SIDE_OPTIONS = %w[BUY SELL].freeze
        TYPE_OPTIONS = %w[LIMIT MARKET].freeze
        TIME_IN_FORCE_OPTIONS = %w[GTC IOC FOK].freeze
        KLINE_INTERVALS = %w[1s 1m 3m 5m 15m 30m 1h 2h 4h 6h 8h 12h 1d 3d 1w 1M].freeze

        config.validate_keys = true

        def self.validate!(args)
          result = new.call(args)
          raise(ContractError, result.errors.to_h) if result.failure?

          result
        end
      end
    end
  end
end
