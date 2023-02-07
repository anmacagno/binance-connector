# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::ExchangeInfoContract do
  it_behaves_like 'a contract', validations: {
    string: %i[symbol],
    format: %i[symbol],
    array: %i[symbols]
  }

  describe '.validate!' do
    subject(:result) { described_class.validate!(args) }

    context 'when args is valid' do
      let(:args) { { symbols: %w[BTCUSDT ETHUSDT] } }

      it 'success' do
        expect(result.success?).to be true
      end

      it 'converts symbols' do
        expect(result[:symbols]).to eq('["BTCUSDT","ETHUSDT"]')
      end
    end

    context 'when args has a disallowed key' do
      let(:args) { { symbols: %w[BTCUSDT ETHUSDT], unexpected: :reality } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { unexpected: ['is not allowed'] }.to_s
        )
      end
    end

    context 'when symbol and symbols are present' do
      let(:args) { { symbol: 'BTCUSDT', symbols: %w[BTCUSDT ETHUSDT] } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { nil => ['must only contain one of: symbol, symbols'] }.to_s
        )
      end
    end
  end
end
