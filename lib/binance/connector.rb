# frozen_string_literal: true

require_relative 'connector/api'
require_relative 'connector/api/account'
require_relative 'connector/api/market'
require_relative 'connector/api/wallet'
require_relative 'connector/contracts/application_contract'
require_relative 'connector/contracts/avg_price_contract'
require_relative 'connector/contracts/exchange_info_contract'
require_relative 'connector/contracts/klines_contract'
require_relative 'connector/contracts/ticker_price_contract'
require_relative 'connector/http_client'
require_relative 'connector/version'

module Binance
  module Connector
    class Error < StandardError; end

    class ContractError < Error; end
  end
end
