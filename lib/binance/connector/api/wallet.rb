# frozen_string_literal: true

module Binance
  module Connector
    class Api
      module Wallet
        def system_status
          HttpClient.get(url('/sapi/v1/system/status'))
        end

        def get_user_asset(args = {})
          result = Contracts::GetUserAssetContract.validate!(args)
          HttpClient.post(url('/sapi/v3/asset/getUserAsset'), options_signed(result.to_h))
        end
      end
    end
  end
end
