# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::GetOrdersContract do
  it_behaves_like 'a contract', validations: {
    required: %i[symbol],
    string: %i[symbol],
    format: %i[symbol]
  }
end
