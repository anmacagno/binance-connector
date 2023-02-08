# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::GetOrderContract do
  it_behaves_like 'a contract', validations: {
    required: %i[symbol orderId],
    integer: %i[orderId],
    string: %i[symbol],
    format: %i[symbol]
  }

  describe '.validate!' do
    subject(:result) { described_class.validate!(args) }

    context 'when args is valid' do
      let(:args) { { symbol: 'AVAXUSDT', orderId: '794968499'.to_i } }

      it 'success' do
        expect(result.success?).to be true
      end
    end

    context 'when args has a disallowed key' do
      let(:args) { { symbol: 'AVAXUSDT', orderId: '794968499'.to_i, unexpected: :reality } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { unexpected: ['is not allowed'] }.to_s
        )
      end
    end
  end
end
