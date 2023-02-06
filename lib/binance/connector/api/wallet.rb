# frozen_string_literal: true

module Binance
  module Connector
    class Api
      module Wallet
        def system_status
          HttpClient.get(url('/sapi/v1/system/status'))
        end
      end
    end
  end
end
