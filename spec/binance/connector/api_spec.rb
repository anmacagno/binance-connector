# frozen_string_literal: true

RSpec.describe Binance::Connector::Api do
  include_context 'with environment variables'

  describe '.base_url' do
    it 'succeeds' do
      expect(described_class.base_url).to eq(
        'https://api.binance.com'
      )
    end
  end

  describe '.api_key' do
    it 'succeeds' do
      expect(described_class.api_key).to eq(
        'vmPUZE6mv9SD5VNHk4HlWFsOr6aKE2zvsw0MuIgwCIPy6utIco14y7Ju91duEh8A'
      )
    end
  end

  describe '.secret_key' do
    it 'succeeds' do
      expect(described_class.secret_key).to eq(
        'NhqPtmdSJYdKjVHjA7PZj4Mge3R5YNiP1e3UZjInClVN65XAbvqqM6A7H5fATj0j'
      )
    end
  end

  describe '.url' do
    it 'succeeds' do
      expect(described_class.url('/path')).to eq(
        'https://api.binance.com/path'
      )
    end
  end

  describe '.options_unsigned' do
    let(:params) { {} }

    it 'succeeds' do
      expect(described_class.options_unsigned(params)).to eq(
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
      expect(described_class.options_signed(params)).to eq(
        {
          query: params.merge(
            {
              recvWindow: 5000,
              timestamp: '1635292800000',
              signature: 'acd753e01ad684b379ad67dd5e395402067e94b17143e30a86c77f2dfe53dff1'
            }
          ),
          headers: { 'X-MBX-APIKEY': 'vmPUZE6mv9SD5VNHk4HlWFsOr6aKE2zvsw0MuIgwCIPy6utIco14y7Ju91duEh8A' }
        }
      )
    end
  end

  describe '.sign_params' do
    before do
      allow(Time).to receive(:now).and_return(
        Time.utc(2021, 10, 27)
      )
    end

    let(:params) { {} }

    it 'succeeds' do
      expect(described_class.sign_params(params)).to eq(
        params.merge(
          {
            recvWindow: 5000,
            timestamp: '1635292800000',
            signature: 'acd753e01ad684b379ad67dd5e395402067e94b17143e30a86c77f2dfe53dff1'
          }
        )
      )
    end
  end

  describe '.timestamp' do
    before do
      allow(Time).to receive(:now).and_return(
        Time.utc(2021, 10, 27)
      )
    end

    it 'succeeds' do
      expect(described_class.timestamp).to eq('1635292800000')
    end
  end
end
