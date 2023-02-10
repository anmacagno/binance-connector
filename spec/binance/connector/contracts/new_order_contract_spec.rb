# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::NewOrderContract do
  it_behaves_like 'a contract', validations: {
    required: %i[symbol side type],
    string: %i[symbol side type time_in_force],
    float: %i[quantity quoteOrderQty price],
    format: %i[symbol],
    inclusion: %i[side type time_in_force]
  }

  describe '.validate!' do
    subject(:result) { described_class.validate!(args) }

    context 'when args is valid' do
      let(:args) { { symbol: 'BTCUSDT', side: 'BUY', type: 'MARKET', quantity: 0.005 } }

      it 'success' do
        expect(result.success?).to be true
      end
    end

    context 'when args has a disallowed key' do
      let(:args) { { symbol: 'BTCUSDT', side: 'BUY', type: 'MARKET', quantity: 0.005, unexpected: :reality } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { unexpected: ['is not allowed'] }.to_s
        )
      end
    end

    context 'when time_in_force is present and type is not limit' do
      let(:args) { { symbol: 'BTCUSDT', side: 'BUY', type: 'MARKET', quantity: 0.005, time_in_force: 'GTC' } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { time_in_force: ['for use only with limit orders'] }.to_s
        )
      end
    end

    context 'when quantity and quoteOrderQty are absent' do
      let(:args) { { symbol: 'BTCUSDT', side: 'BUY', type: 'MARKET' } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { nil => ['must contain one of: quantity, quoteOrderQty'] }.to_s
        )
      end
    end

    context 'when quantity and quoteOrderQty are present' do
      let(:args) { { symbol: 'BTCUSDT', side: 'BUY', type: 'MARKET', quantity: 0.005, quoteOrderQty: 100.0 } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { nil => ['must only contain one of: quantity, quoteOrderQty'] }.to_s
        )
      end
    end

    context 'when price is present and type is not limit' do
      let(:args) { { symbol: 'BTCUSDT', side: 'BUY', type: 'MARKET', quantity: 0.005, price: 20_000.0 } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { price: ['for use only with limit orders'] }.to_s
        )
      end
    end
  end
end
