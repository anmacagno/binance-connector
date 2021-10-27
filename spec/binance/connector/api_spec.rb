# frozen_string_literal: true

RSpec.describe Binance::Connector::Api do
  describe '.url' do
    it 'succeeds' do
      expect(described_class.url('/path')).to eq(
        "#{Binance::Connector::Api::BASE_URL}/path"
      )
    end
  end

  describe '.options' do
    before do
      allow(ENV).to receive(:fetch).with('BINANCE_API_KEY').and_return(
        'vmPUZE6mv9SD5VNHk4HlWFsOr6aKE2zvsw0MuIgwCIPy6utIco14y7Ju91duEh8A'
      )
      allow(ENV).to receive(:fetch).with('BINANCE_SECRET_KEY').and_return(
        'NhqPtmdSJYdKjVHjA7PZj4Mge3R5YNiP1e3UZjInClVN65XAbvqqM6A7H5fATj0j'
      )
    end

    let(:params) { {} }

    context 'when security type is none' do
      let(:security_type) { :none }

      it 'succeeds' do
        expect(described_class.options(params, security_type)).to eq(
          {
            query: params
          }
        )
      end
    end

    context 'when security type is user_data' do
      let(:security_type) { :user_data }

      it 'succeeds' do
        expect(described_class.options(params, security_type)).to eq(
          {
            query: params.merge(signature: '18f82ab1c4ba20d60cb86ebc4cab5b54ddb974cdf7832421345148e7a7f9466e'),
            headers: { 'X-MBX-APIKEY': 'vmPUZE6mv9SD5VNHk4HlWFsOr6aKE2zvsw0MuIgwCIPy6utIco14y7Ju91duEh8A' }
          }
        )
      end
    end

    context 'when security type is user_stream' do
      let(:security_type) { :user_stream }

      it 'succeeds' do
        expect(described_class.options(params, security_type)).to eq(
          {
            query: params,
            headers: { 'X-MBX-APIKEY': 'vmPUZE6mv9SD5VNHk4HlWFsOr6aKE2zvsw0MuIgwCIPy6utIco14y7Ju91duEh8A' }
          }
        )
      end
    end
  end

  describe '.sign_params' do
    before do
      allow(ENV).to receive(:fetch).with('BINANCE_SECRET_KEY').and_return(
        'NhqPtmdSJYdKjVHjA7PZj4Mge3R5YNiP1e3UZjInClVN65XAbvqqM6A7H5fATj0j'
      )
    end

    let(:params) { { recvWindow: 5000, timestamp: '1635283424006'.to_i } }

    it 'succeeds' do
      expect(described_class.sign_params(params)).to eq(
        '970b70cab6eaf08cd54d819ab45eeed3833d6a977ec255a969fa1b9ecc269396'
      )
    end
  end

  describe '.ping' do
    let(:json) { JSON.parse(File.read('spec/fixtures/ping.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.ping).to eq(
        {}
      )
    end
  end

  describe '.time' do
    let(:json) { JSON.parse(File.read('spec/fixtures/time.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.time.keys).to match_array(
        %i[serverTime]
      )
    end
  end

  describe '.exchange_info' do
    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    context 'when the symbols are valid' do
      let(:json) { JSON.parse(File.read('spec/fixtures/exchangeInfo.json'), symbolize_names: true) }

      it 'succeeds' do
        expect(described_class.exchange_info(%w[BTCUSDT ETHUSDT]).keys).to match_array(
          %i[timezone serverTime rateLimits exchangeFilters symbols]
        )
      end
    end
  end

  describe '.avg_price' do
    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    context 'when the symbol is valid' do
      let(:json) { JSON.parse(File.read('spec/fixtures/avgPrice.json'), symbolize_names: true) }

      it 'succeeds' do
        expect(described_class.avg_price('ETHUSDT').keys).to match_array(
          %i[mins price]
        )
      end
    end
  end
end
