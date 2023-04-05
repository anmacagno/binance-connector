# frozen_string_literal: true

module Binance
  module Connector
    module Contracts
      class GetUserAssetContract < ApplicationContract
        schema do
          optional(:asset).filled(:string)
        end
      end
    end
  end
end
