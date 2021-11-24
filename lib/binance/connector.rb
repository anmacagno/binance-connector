# frozen_string_literal: true

require_relative 'connector/api'
require_relative 'connector/api/account'
require_relative 'connector/api/market'
require_relative 'connector/api/wallet'
require_relative 'connector/http_client'
require_relative 'connector/version'

module Binance
  module Connector
    class Error < StandardError; end
  end
end
