# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::KlinesContract do
  it_behaves_like 'a contract', validations: {
    required: %i[symbol interval],
    string: %i[symbol interval],
    format: %i[symbol],
    inclusion: %i[interval]
  }
end
