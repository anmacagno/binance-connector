# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Market do
  include_context 'with environment variables'
  include_context 'with mocked http responses'

  describe '.ping' do
    let(:json) { File.read('spec/fixtures/market/ping.json') }

    it 'succeeds' do
      expect(described_class.ping).to eq(
        {}
      )
    end
  end

  describe '.time' do
    let(:json) { File.read('spec/fixtures/market/time.json') }

    it 'succeeds' do
      expect(described_class.time.keys).to match_array(
        %i[serverTime]
      )
    end
  end

  describe '.exchange_info' do
    let(:json) { File.read('spec/fixtures/market/exchange_info.json') }

    it 'succeeds' do
      expect(described_class.exchange_info(%w[BTCUSDT ETHUSDT]).keys).to match_array(
        %i[timezone serverTime rateLimits exchangeFilters symbols]
      )
    end
  end

  describe '.klines' do
    let(:json) { File.read('spec/fixtures/market/klines.json') }

    it 'succeeds' do
      expect(described_class.klines('ETHUSDT', '1d', nil, nil, '7').size).to eq(7)
    end
  end

  describe '.avg_price' do
    let(:json) { File.read('spec/fixtures/market/avg_price.json') }

    it 'succeeds' do
      expect(described_class.avg_price('ETHUSDT').keys).to match_array(
        %i[mins price]
      )
    end
  end

  describe '.ticker_price' do
    let(:json) { File.read('spec/fixtures/market/ticker_price.json') }

    it 'succeeds' do
      expect(described_class.ticker_price('ETHUSDT').keys).to match_array(
        %i[symbol price]
      )
    end
  end
end
