# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::KlinesContract do
  it_behaves_like 'a contract', validations: {
    required: %i[symbol interval],
    integer: %i[limit],
    string: %i[symbol interval],
    time: %i[startTime endTime],
    format: %i[symbol],
    inclusion: %i[interval]
  }

  describe '.validate!' do
    subject(:result) { described_class.validate!(args) }

    context 'when args is valid' do
      let(:args) { { symbol: 'ETHUSDT', interval: '1d', startTime: Time.utc(2022), endTime: Time.utc(2023) } }

      it 'success' do
        expect(result.success?).to be true
      end

      it 'converts startTime' do
        expect(result[:startTime]).to eq('1640995200000')
      end

      it 'converts endTime' do
        expect(result[:endTime]).to eq('1672531200000')
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
