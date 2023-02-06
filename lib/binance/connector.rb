# frozen_string_literal: true

require_relative 'connector/api'
require_relative 'connector/http_client'
require_relative 'connector/version'
require_relative 'connector/contracts/application_contract'
Dir['./lib/binance/connector/contracts/*.rb'].each { |f| require f }

module Binance
  module Connector
    class Error < StandardError; end

    class ContractError < Error; end
  end
end
