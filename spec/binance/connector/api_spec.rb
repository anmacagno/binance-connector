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

    %i[trade margin user_data].each do |security_type|
      context "when security type is #{security_type}" do
        it 'succeeds' do
          expect(described_class.options(params, security_type)).to eq(
            {
              query: params.merge(signature: '18f82ab1c4ba20d60cb86ebc4cab5b54ddb974cdf7832421345148e7a7f9466e'),
              headers: { 'X-MBX-APIKEY': 'vmPUZE6mv9SD5VNHk4HlWFsOr6aKE2zvsw0MuIgwCIPy6utIco14y7Ju91duEh8A' }
            }
          )
        end
      end
    end

    %i[user_stream market_data].each do |security_type|
      context "when security type is #{security_type}" do
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
  end

  describe '.sign_params' do
    before do
      allow(ENV).to receive(:fetch).with('BINANCE_SECRET_KEY').and_return(
        'NhqPtmdSJYdKjVHjA7PZj4Mge3R5YNiP1e3UZjInClVN65XAbvqqM6A7H5fATj0j'
      )
    end

    let(:params) { { recvWindow: 5000, timestamp: '1635283424006' } }

    it 'succeeds' do
      expect(described_class.sign_params(params)).to eq(
        '970b70cab6eaf08cd54d819ab45eeed3833d6a977ec255a969fa1b9ecc269396'
      )
    end
  end

  describe '.timestamp' do
    before do
      allow(Time).to receive(:now).and_return(Time.new('2021-10-27'))
    end

    it 'succeeds' do
      expect(described_class.timestamp).to eq('1609480800000')
    end
  end
end
