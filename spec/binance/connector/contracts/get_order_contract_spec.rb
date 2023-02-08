# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::GetOrderContract do
  it_behaves_like 'a contract', validations: {
    required: %i[symbol orderId],
    integer: %i[orderId],
    string: %i[symbol],
    format: %i[symbol]
  }
end
