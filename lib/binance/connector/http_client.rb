# frozen_string_literal: true

module Binance
  module Connector
    module HttpClient
      require 'httparty'

      def self.get(url, options = {})
        response = HTTParty.get(url, options.merge({ format: :plain }))
        parse_response(response)
      end

      def self.post(url, options = {})
        response = HTTParty.post(url, options.merge({ format: :plain }))
        parse_response(response)
      end

      def self.delete(url, options = {})
        response = HTTParty.delete(url, options.merge({ format: :plain }))
        parse_response(response)
      end

      def self.parse_response(response)
        json = JSON.parse(response, symbolize_names: true)
        raise(RequestError.new(json[:code], json[:msg])) unless response.code.eql?(200)

        json
      end
    end
  end
end
