# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::GetOpenOrdersContract do
  it_behaves_like 'a contract', validations: {
    string: %i[symbol],
    format: %i[symbol]
  }
end
