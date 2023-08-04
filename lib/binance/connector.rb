# frozen_string_literal: true

require_relative 'connector/api'
require_relative 'connector/http_client'
require_relative 'connector/version'
require_relative 'connector/contracts/application_contract'
require_relative 'connector/contracts/avg_price_contract'
require_relative 'connector/contracts/cancel_order_contract'
require_relative 'connector/contracts/exchange_info_contract'
require_relative 'connector/contracts/get_open_orders_contract'
require_relative 'connector/contracts/get_order_contract'
require_relative 'connector/contracts/get_orders_contract'
require_relative 'connector/contracts/get_user_asset_contract'
require_relative 'connector/contracts/klines_contract'
require_relative 'connector/contracts/my_trades_contract'
require_relative 'connector/contracts/new_order_contract'
require_relative 'connector/contracts/ticker_price_contract'

module Binance
  module Connector
    class Error < StandardError; end

    class ContractError < Error; end

    class RequestError < Error
      attr_reader :code, :message

      def initialize(code, message)
        super()
        @code = code
        @message = message
      end

      def to_s
        "#{message} (#{code})"
      end
    end
  end
end
