# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::GetUserAssetContract do
  it_behaves_like 'a contract', validations: {
    string: %i[asset]
  }

  describe '.validate!' do
    subject(:result) { described_class.validate!(args) }

    context 'when args is valid' do
      let(:args) { { asset: 'BTC' } }

      it 'success' do
        expect(result.success?).to be true
      end
    end

    context 'when args has a disallowed key' do
      let(:args) { { asset: 'BTC', unexpected: :reality } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { unexpected: ['is not allowed'] }.to_s
        )
      end
    end
  end
end
