# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::AvgPriceContract do
  it_behaves_like 'a contract', validations: {
    required: %i[symbol],
    string: %i[symbol],
    format: %i[symbol]
  }

  describe '.validate!' do
    subject(:result) { described_class.validate!(args) }

    context 'when args is valid' do
      let(:args) { { symbol: 'ETHUSDT' } }

      it 'success' do
        expect(result.success?).to be true
      end
    end

    context 'when args is not valid' do
      let(:args) { { unexpected: :reality } }

      it 'raises an error' do
        expect { result }.to raise_error(Binance::Connector::ContractError)
      end
    end
  end
end
