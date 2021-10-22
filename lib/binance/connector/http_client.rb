# frozen_string_literal: true

module Binance
  module Connector
    module HttpClient
      require 'httparty'

      def self.get(url, options = {})
        response = HTTParty.get(url, options.merge({ format: :plain }))
        JSON.parse(response, symbolize_names: true)
      end
    end
  end
end
