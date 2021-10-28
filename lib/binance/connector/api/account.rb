# frozen_string_literal: true

module Binance
  module Connector
    module Api
      module Account
        def self.account
          params = { recvWindow: 5000, timestamp: Api.timestamp }
          HttpClient.get(Api.url('/api/v3/account'), Api.options(params, :user_data))
        end
      end
    end
  end
end
