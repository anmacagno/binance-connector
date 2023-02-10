# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::KlinesContract do
  it_behaves_like 'a contract', validations: {
    required: %i[symbol interval],
    string: %i[symbol interval],
    integer: %i[limit],
    time: %i[startTime endTime],
    format: %i[symbol],
    inclusion: %i[interval]
  }

  describe '.validate!' do
    subject(:result) { described_class.validate!(args) }

    context 'when args is valid' do
      let(:args) { { symbol: 'BTCUSDT', interval: '1d', startTime: Time.utc(2022), endTime: Time.utc(2023) } }

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

    context 'when args has a disallowed key' do
      let(:args) { { symbol: 'BTCUSDT', interval: '1d', unexpected: :reality } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { unexpected: ['is not allowed'] }.to_s
        )
      end
    end

    context 'when limit is less than 1' do
      let(:args) { { symbol: 'BTCUSDT', interval: '1d', limit: 0 } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { limit: ['must be greater than or equal to 1'] }.to_s
        )
      end
    end

    context 'when limit is greater than 1000' do
      let(:args) { { symbol: 'BTCUSDT', interval: '1d', limit: 1001 } }

      it 'raises an error' do
        expect { result }.to raise_error(
          Binance::Connector::ContractError, { limit: ['must be less than or equal to 1000'] }.to_s
        )
      end
    end
  end
end
