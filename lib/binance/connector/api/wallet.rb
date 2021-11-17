# frozen_string_literal: true

module Binance
  module Connector
    module Api
      module Wallet
        def self.system_status
          HttpClient.get(Api.url('/sapi/v1/system/status'))
        end
      end
    end
  end
end
