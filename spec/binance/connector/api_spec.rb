# frozen_string_literal: true

RSpec.describe Binance::Connector::Api do
  subject(:api) { described_class.new(api_key: 'BINANCE_API_KEY', secret_key: 'BINANCE_SECRET_KEY') }

  describe '.url' do
    it 'succeeds' do
      expect(api.url('/api/v3/order')).to eq(
        'https://api.binance.com/api/v3/order'
      )
    end
  end

  describe '.options_unsigned' do
    let(:params) { {} }

    it 'succeeds' do
      expect(api.options_unsigned(params)).to eq(
        { query: params }
      )
    end
  end

  describe '.options_signed' do
    before do
      allow(Time).to receive(:now).and_return(
        Time.utc(2023, 1, 31)
      )
    end

    context 'when params is empty' do
      let(:params) { {} }

      it 'succeeds' do
        expect(api.options_signed(params)).to eq(
          {
            query: params.merge(
              {
                recvWindow: 5000,
                timestamp: '1675123200000',
                signature: 'c651982571bbd314e63ffbc7fa830e9d9fc4d96efb4d79f9dcccdc0838fe7b59'
              }
            ),
            headers: { 'X-MBX-APIKEY': 'BINANCE_API_KEY' }
          }
        )
      end
    end

    context 'when params is not empty' do
      let(:params) { { symbol: 'BTCUSDT', side: 'BUY', type: 'MARKET', quantity: 0.005 } }

      it 'succeeds' do
        expect(api.options_signed(params)).to eq(
          {
            query: params.merge(
              {
                recvWindow: 5000,
                timestamp: '1675123200000',
                signature: '29cf072c2037a26a70948b13653cf71253333123e09aa45c5cd482f1d90db6a2'
              }
            ),
            headers: { 'X-MBX-APIKEY': 'BINANCE_API_KEY' }
          }
        )
      end
    end
  end
end
