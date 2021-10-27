# frozen_string_literal: true

module Binance
  module Connector
    module Api
      module Account
        def self.account
          params = { recvWindow: 5000, timestamp: Time.now.utc.strftime('%s%3N') }
          HttpClient.get(
            Binance::Connector::Api.url('/api/v3/account'),
            Binance::Connector::Api.options(params, :user_data)
          )
        end
      end
    end
  end
end
