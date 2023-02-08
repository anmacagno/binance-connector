# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::MyTradesContract do
  it_behaves_like 'a contract', validations: {
    required: %i[symbol],
    integer: %i[orderId],
    string: %i[symbol],
    format: %i[symbol]
  }
end
