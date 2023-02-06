# frozen_string_literal: true

RSpec.describe Binance::Connector::Api do
  subject(:api) { described_class.new }

  describe '.url' do
    it 'succeeds' do
      expect(api.url('/path')).to eq(
        'https://api.binance.com/path'
      )
    end
  end

  describe '.options_unsigned' do
    let(:params) { {} }

    it 'succeeds' do
      expect(api.options_unsigned(params)).to eq(
        {
          query: params
        }
      )
    end
  end

  describe '.options_signed' do
    before do
      allow(Time).to receive(:now).and_return(
        Time.utc(2021, 10, 27)
      )
    end

    let(:params) { {} }

    it 'succeeds' do
      expect(api.options_signed(params)).to eq(
        {
          query: params.merge(
            {
              recvWindow: 5000,
              timestamp: '1635292800000',
              signature: '2e2a239db849bbac570ee1c25686876b6ef0c7ff0c8a3aa048a9262f2772c9c6'
            }
          ),
          headers: { 'X-MBX-APIKEY': '' }
        }
      )
    end
  end
end
