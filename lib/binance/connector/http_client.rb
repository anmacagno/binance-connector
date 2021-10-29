# frozen_string_literal: true

module Binance
  module Connector
    module HttpClient
      require 'httparty'

      def self.get(url, options = {})
        response = HTTParty.get(url, options.merge({ format: :plain }))
        JSON.parse(response, symbolize_names: true)
      end

      def self.post(url, options = {})
        response = HTTParty.post(url, options.merge({ format: :plain }))
        JSON.parse(response, symbolize_names: true)
      end

      def self.delete(url, options = {})
        response = HTTParty.delete(url, options.merge({ format: :plain }))
        JSON.parse(response, symbolize_names: true)
      end
    end
  end
end
