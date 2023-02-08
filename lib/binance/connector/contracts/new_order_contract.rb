# frozen_string_literal: true

module Binance
  module Connector
    module Contracts
      class NewOrderContract < ApplicationContract
        schema do
          required(:symbol).filled(:string, format?: SYMBOL_REGEXP)
          required(:side).filled(:string, included_in?: SIDE_OPTIONS)
          required(:type).filled(:string, included_in?: TYPE_OPTIONS)
          optional(:time_in_force).filled(:string, included_in?: TIME_IN_FORCE_OPTIONS)
          optional(:quantity).value(:decimal)
          optional(:quoteOrderQty).value(:decimal)
          optional(:price).value(:decimal)
        end

        rule(:time_in_force) do
          key.failure('for use only with limit orders') if key? && !values[:type].eql?('LIMIT')
        end

        rule(:quantity, :quoteOrderQty) do
          base.failure('must contain one of: quantity, quoteOrderQty') if !key?(:quantity) && !key?(:quoteOrderQty)
          base.failure('must only contain one of: quantity, quoteOrderQty') if key?(:quantity) && key?(:quoteOrderQty)
        end

        rule(:price) do
          key.failure('for use only with limit orders') if key? && !values[:type].eql?('LIMIT')
        end
      end
    end
  end
end
